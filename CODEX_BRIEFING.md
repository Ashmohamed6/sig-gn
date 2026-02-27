# Briefing Codex - Projet SIG GN

## Contexte projet

WebSIG pour la Guinee (programmes FIERE/AGRIECO). Plateforme de consultation cartographique, indicateurs dashboard, administration utilisateurs, workflow de validation des donnees terrain.

## Stack technique

- **Backend** : Django 5.2 + DRF + SimpleJWT + PostGIS 17 (port 8000)
- **Frontend** : Next.js 16.0.11 + React 19 + Leaflet + TailwindCSS + Recharts (port 3001)
- **DB** : PostgreSQL/PostGIS, base `sig_territoires_gn`
- **Schemas DB** : `ref`, `core`, `stage`, `marts`, `audit`, `qa`, `security`, `import`, `public`
- **Docker Compose** : `cd docker && docker compose -f docker-compose.dev.yml up --build -d`
- **Containers** : `siggn_db` (5432), `siggn_backend` (8000), `siggn_frontend` (3001)

## Architecture auth

- Tokens JWT stockes en **cookies HTTP-only** (PAS localStorage)
- Routes auth Next.js : `/api/auth/login`, `/api/auth/me`, `/api/auth/refresh`, `/api/auth/logout`
- Proxy API : `/api/proxy/[...path]/route.ts` → forward vers Django backend avec Bearer token
- CSRF : header `X-SIG-Intent: 1` requis sur toutes les requetes mutantes
- Fichiers cles :
  - `sig-gn-frontend/utils/authClient.ts` (client-side auth)
  - `sig-gn-frontend/utils/api.ts` (server-side API utils)
  - `sig-gn-frontend/utils/auth.ts` (cookie management)
  - `sig-gn-frontend/app/api/proxy/[...path]/route.ts` (proxy)

## Roles utilisateur

Hierarchie : `reader` < `editor` < `manager` < `project_manager` < `admin`
- `reader` = lecteur
- `editor` = superviseur terrain
- `manager` = chef d'equipe (Admin N1, scope region)
- `project_manager` = chef de projet (Admin N2, scope projet multi-region)
- `admin` = admin global (tous projets, toutes regions)

## Structure backend (sig-gn-backend/)

```
accounts/          # Auth, JWT, middleware projet, throttles
admin_core/        # CRUD utilisateurs, permissions scope sous-admin
data_api/          # ~100 vues (stats, geojson, donnees tabulaires) - SQL brut
  views.py         # ~430KB, le plus gros fichier (SELECT * FROM marts.vw_*)
  views_agrieco_aggregates.py
  views_fiere_aggregates.py
  views_geojson_collected.py
  views_geojson_ref.py
  mixins.py        # CurrentProjectRequiredMixin + build_access_scope_for_project()
  urls.py          # 18 endpoints data tabulaires + carto + stats
workflow_core/     # Workflow validation + Kobo sync
  models.py        # WorkflowSubmission, WorkflowActionLog
  views.py         # CRUD submissions + actions (submit/validate/reject/publish)
  kobo.py          # Client API Kobo
  serializers.py   # Dont WorkflowRejectSerializer
dashboard/         # App vide (pas utilisee)
config/            # settings.py, urls.py
```

### Endpoints data tabulaires (data_api/urls.py)

Tous les endpoints utilisent `SELECT * FROM marts.vw_*` avec `build_access_scope_for_project()` pour le scoping utilisateur.

**AGRIECO (11) :**
| Endpoint | Vue marts | Table frontend |
|---|---|---|
| `/data/cep-parcelles/` | vw_cep_parcelle | CEP (Parcelles) |
| `/data/intrants-distribution/` | vw_intrant_distribution | Intrants |
| `/data/ouvrages/` | vw_ouvrage | Ouvrages |
| `/data/zone-degradee/` | vw_zone_degradee | Zones degradees |
| `/data/tete-source/` | vw_tete_source | Tetes de sources |
| `/data/couloirs/` | vw_couloir | Couloirs transhumance |
| `/data/agr-organisations/` | vw_agr_organisation | Organisations |
| `/data/agr-menages/` | vw_agr_menage | Menages |
| `/data/agr-comites/` | vw_agr_comite | Comites |
| `/data/meteo/stations/` | vw_meteo_station | Stations meteo |
| `/data/marches/` | vw_marche | Marches |

**FIERE (5) :**
| Endpoint | Vue marts | Table frontend |
|---|---|---|
| `/data/formations-eco-cat/` | vw_formation_eco_cat | Formations |
| `/data/entreprises/` | vw_entreprise | Entreprises |
| `/data/fiere-suivi-sortants/` | vw_fiere_suivi_sortant | Suivi sortants |
| `/data/ent-emplois-dom/` | vw_ent_emploi_dom | Emplois |
| `/data/ent-insertions-dom/` | vw_ent_insertion_dom | Insertions |

## Structure frontend (sig-gn-frontend/)

```
app/(protected)/
  layout.tsx                 # Layout principal avec sidebar + topbar + auth guard
  dashboard/page.tsx         # 1867 lignes, KPIs + charts (USE_INLINE_MOCK=false)
  cartographie/              # Module carte
    page.tsx                     # Orchestration, chargement GeoJSON, handlers impression
    config/
      layersConfig.ts            # 14 couches, LayerStyle.markerShape, MAP_CONFIG (maxZoom=20)
      layerStyles.ts             # createMarkerIcon(shape), getIconSvg (exporte), getLegendPreview
    components/
      MapContainer.tsx           # detectGeometryType(), createPointLayer(shape), fallback pointToLayer
      LayerPanel.tsx             # Legende vrais marqueurs SVG miniatures (dangerouslySetInnerHTML)
      MapToolbar.tsx             # Outils zoom, reset, impression
      MeasureTools.tsx           # Distance, surface
      PrintModal.tsx             # Export carte PDF
    hooks/
      useMapLayers.ts            # Etats couches/groupes, basemap, labels admin
      useGeoJSON.ts              # Cache GeoJSON + clearGeoJSONCache()
    utils/
      printUtils.ts              # exportMap(), getMapBounds()
  data/                      # Module donnees tabulaires (16 tables)
    page.tsx                     # handleAction (view_map/view_detail/export_pdf/edit), role-based edit
    config/
      tablesConfig.ts            # 11 AGRIECO + 5 FIERE, 4 actions standardisees, minRole chef_projet
    components/
      DataTable.tsx              # Table paginee, tri, selection, actions par ligne
      DataFilters.tsx            # Filtres globaux (cascade region/pref/commune) + specifiques
      EntitySheet.tsx            # Fiche detail slide-over, export PDF individuel (jspdf-autotable)
      ExportMenu.tsx             # Export CSV/XLSX/PDF/GeoJSON
    hooks/
      useDataTable.ts            # Pagination, tri, filtres, search debounce, export
  workflow/page.tsx          # 2023 lignes, monolithe (Kobo, CSV, review, carte geo)
  administration/            # Tabs: QA, imports, referentiels, users
  profile/page.tsx
  no-project/page.tsx
  map/page.tsx               # Legacy, doublon avec cartographie/

utils/
  authClient.ts              # getUser(), login(), logout(), selectProject()
  api.ts                     # apiRequest(), authenticatedApiRequest()
  auth.ts                    # setAuthCookies(), clearAuthCookies()
  dashboardApi.ts            # apiGet(), fetchAgriecoAggregates(), fetchFiereAggregates()

hooks/
  useUser.ts                 # React Query hook pour currentUser
  useLogin.ts                # Mutation hook login

types/
  roles.ts                   # normalizeUserRole(), hasRole(), canAccessAdministration()
  auth.ts                    # User type
```

## Cartographie - Reference marqueurs

Chaque couche ponctuelle a une forme (`markerShape`) + couleur + icone SVG uniques :

**Infrastructure :**
| Couche | Forme | Couleur | Icone |
|---|---|---|---|
| equipements | square | #0369a1 | Building |
| localites | circle | #475569 | MapPin |
| habitations_dispersees | diamond | #92400e | Home |

**AGRIECO :**
| Couche | Forme | Couleur | Icone |
|---|---|---|---|
| tetes_sources | diamond | #0e7490 | Droplets |
| stations_meteo | square | #1d4ed8 | CloudRain |
| ouvrages | diamond | #4f46e5 | Wrench |
| organisations | circle | #7c3aed | Users |
| menages | square | #be123c | Home |
| marches | diamond | #c026d3 | Store |

**FIERE :**
| Couche | Forme | Couleur | Icone |
|---|---|---|---|
| entreprises | square | #1e40af | Building2 |
| formations | diamond | #b45309 | GraduationCap |
| sortants | circle | #15803d | UserCheck |

## Module Donnees - Reference tables

16 tables dans `tablesConfig.ts`, toutes avec 4 actions standardisees :
- `view_map` : naviguer vers /cartographie avec zoom sur entite
- `view_detail` : ouvrir EntitySheet (fiche detail slide-over)
- `export_pdf` : generer fiche PDF individuelle (jspdf-autotable)
- `edit` : ouvrir en mode edition (minRole: `chef_projet`)

**Scoping des donnees :**
- Filtrage automatique par projet via header `X-Project-Code`
- Filtrage par scope utilisateur via `build_access_scope_for_project()` (backend)
- Filtres cascade : region → prefecture → commune (endpoints `/data/carto/admin-*`)
- Un `reader` FIERE/Kindia ne voit QUE les donnees FIERE de la region Kindia

## Conventions du projet

1. **Pas de localStorage pour les tokens** - cookies HTTP-only uniquement
2. **Proxy obligatoire** - le frontend n'appelle jamais le backend directement, tout passe par `/api/proxy/...`
3. **X-Project-Code** header requis sur les endpoints data/stats/carto
4. **X-SIG-Intent: 1** header requis sur les POST/PUT/PATCH/DELETE vers `/api/auth/*` et `/api/proxy/*`
5. **Accents UTF-8** - ne jamais ecrire `\u00e9`, ecrire directement `é`
6. **Pas de console.log** - les logs debug ont ete supprimes pour securite
7. **Tests backend** - `SimpleTestCase` avec mocks (pas de DB test, le schema est trop complexe)
8. **Documentation** - mettre a jour `documentation_ch.md` apres chaque modification significative

## Commandes utiles

```bash
# Containers
docker ps
docker logs siggn_frontend --tail 30
docker logs siggn_backend --tail 30
docker restart siggn_frontend
docker restart siggn_backend

# Tests backend (46 tests)
docker exec siggn_backend python manage.py test accounts admin_core data_api workflow_core -v 2

# Check backend
docker exec siggn_backend python manage.py check

# Shell Django
docker exec -it siggn_backend python manage.py shell

# Lint frontend
docker exec siggn_frontend npx eslint "app/(protected)/workflow/page.tsx"
docker exec siggn_frontend npx tsc --noEmit
```

## Comptes de test

| Username | Password | Role | Projet |
|---|---|---|---|
| mohamed | SigGn2024! | admin (staff) | tous |
| qa_admin_global | Recette@2026! | admin | tous |
| qa_pm_fiere | Recette@2026! | project_manager | FIERE |
| qa_pm_agrieco | Recette@2026! | project_manager | AGRIECO |
| qa_sa_fiere_kindia | Recette@2026! | manager | FIERE, region GN005 |
| qa_sa_agrieco_mamou | Recette@2026! | manager | AGRIECO, region GN007 |
| qa_fiere_kindia | Recette@2026! | editor | FIERE, region GN005 |
| qa_agrieco_mamou | Test1234! | editor | AGRIECO, region GN007 |

## Etat actuel - CE QUI FONCTIONNE

1. Auth complete (login/logout/refresh/me) via cookies HTTP-only
2. Proxy API avec auto-refresh token
3. Dashboard connecte aux vraies API (13 AGRIECO + 6 FIERE endpoints, tous 200)
4. Cartographie complete :
   - 14 couches GeoJSON via proxy (points, lignes, polygones)
   - Symbologie differenciee : 3 formes de marqueurs (circle/square/diamond) + couleurs distinctes
   - Icones SVG reels dans les marqueurs (Building, Users, CloudRain, Wrench, Droplets, etc.)
   - Legende fidele aux marqueurs carte (miniatures SVG avec forme/couleur)
   - Detection auto du type geometrie (fallback si API renvoie Point pour config Polygon)
   - Zoom max 20, fonds de carte multiples, labels admin, outils de mesure
5. Module data complet (16 tables) :
   - 11 AGRIECO : CEP, intrants, ouvrages, zones degradees, tetes sources, couloirs, organisations, menages, comites, stations meteo, marches
   - 5 FIERE : formations, entreprises, suivi sortants, emplois, insertions
   - 4 actions standardisees : voir carte, voir detail, exporter fiche PDF, modifier
   - Permissions : modification reservee chef_projet+ (Admin N1/N2/global)
   - Export PDF individuel par entite (jspdf-autotable)
   - Filtres specifiques par table + filtres globaux (region/prefecture/commune/campagne)
   - EntitySheet avec identification, localisation, donnees, metadonnees
6. Administration utilisateurs (CRUD, scope sous-admin, reset password)
7. Workflow complet (brouillon → soumis → valide/rejete → publie)
8. Kobo sync (11 forms AGRIECO, 5 FIERE)
9. Upload CSV terrain
10. Rejet qualite enrichi (anomalies, contact enqueteur)
11. Carte geometrie dans workflow
12. Libelles metier automatiques
13. Securite : throttling, CSRF, headers, secrets prod, tests
14. 46 tests backend tous verts
15. 0 encodage Unicode echappe, 0 mojibake, 0 console.log

## Modifications recentes

### Refonte symbologie cartographique (FAIT)
- 3 formes de marqueurs : `circle`, `square`, `diamond` (via `LayerStyle.markerShape`)
- Couleurs uniques pour chaque couche (plus de doublons)
- Icones SVG manquantes ajoutees : CloudRain, Wrench, Droplet
- Legende (LayerPanel) affiche les vrais marqueurs SVG miniatures
- Detection auto du type geometrie : si l'API renvoie des Points pour une couche Polygon, fallback `L.circleMarker`
- `MAP_CONFIG.maxZoom` passe de 18 a 20
- Fichiers : `layersConfig.ts`, `layerStyles.ts`, `MapContainer.tsx`, `LayerPanel.tsx`

### Module Donnees complet (FAIT)
- 6 tables ajoutees : menages, comites, stations meteo (AGRIECO) + sortants, emplois, insertions (FIERE)
- Total : 16 tables (11 AGRIECO + 5 FIERE) correspondant aux 16 formulaires Kobo
- Actions standardisees sur toutes les tables : `view_map`, `view_detail`, `export_pdf`, `edit`
- Permissions : `edit` reserve a `chef_projet`+ (Admin N1, N2, global)
- Export PDF individuel par entite via jspdf-autotable
- EntitySheet wire-up complet : `onEdit` (conditionnel au role), `onPrint` (export PDF)
- Double-filtrage corrige dans `availableTables`
- Styling titre corrige (`text-slate-100` → `text-slate-800` sur fond clair)
- `getIdField` mis a jour avec tous les IDs des 16 tables
- Fichiers : `tablesConfig.ts`, `page.tsx`, `EntitySheet.tsx`

## KPIs a 0 - C'EST NORMAL

Les schemas `core` et `marts` sont vides. Le flux de données :
```
Kobo/CSV → workflow (payload JSON) → [MANQUANT: ETL] → stage → core → marts → dashboard/carto
```

---

# TACHES A FAIRE

## Tache 1 : Nettoyage fichiers (FACILE)

### 1a. Supprimer le fichier backup dashboard
- Supprimer : `sig-gn-frontend/app/(protected)/dashboard/page - Copie.tsx`

### 1b. Supprimer/rediriger la page legacy map
- Le fichier `sig-gn-frontend/app/(protected)/map/page.tsx` est un doublon de `cartographie/`
- Option : supprimer le dossier `map/` ou le remplacer par un redirect vers `/cartographie`

### 1c. Verifier les composants legacy map
- `sig-gn-frontend/components/map/MapComponent.tsx` et `MapFilters.tsx`
- Verifier s'ils sont importes quelque part. Si non, les supprimer.

---

## Tache 2 : Decoupe workflow/page.tsx (MOYEN)

Le fichier `sig-gn-frontend/app/(protected)/workflow/page.tsx` fait 2023 lignes.
Le decoupe en composants comme le module cartographie :

Suggestion de structure :
```
workflow/
  page.tsx                          # Page principale, orchestration
  components/
    SubmissionGeometryMap.tsx        # (existe deja)
    SubmissionList.tsx               # Liste paginee + filtres
    SubmissionDetail.tsx             # Detail d'une soumission
    SubmissionForm.tsx               # Formulaire creation (Kobo/CSV/Manuel)
    ReviewPanel.tsx                  # Panel validation/rejet pour manager+
    SubmissionHistory.tsx            # Historique des actions
    RecordsTable.tsx                 # Table des enregistrements terrain
  hooks/
    useWorkflowApi.ts               # Appels API workflow
  config/
    fieldLabels.ts                   # Dictionnaires libelles metier
    datasetAliases.ts                # Alias dataset codes
```

**Convention** : le proxy est appele via fetch avec `credentials: "include"` et headers `X-SIG-Intent: 1` + `X-Project-Code`.

---

## Tache 3 : Decoupe dashboard/page.tsx (MOYEN)

Le fichier `sig-gn-frontend/app/(protected)/dashboard/page.tsx` fait 1867 lignes.

Suggestion de structure :
```
dashboard/
  page.tsx                          # Page principale
  components/
    KpiCard.tsx                     # Carte KPI individuelle
    KpiGrid.tsx                     # Grille de KPIs
    ChartSection.tsx                # Section graphiques
    DashboardHeader.tsx             # Header avec projet + actions
  config/
    kpiDefinitions.ts               # Definitions des KPIs par programme
    chartConfig.ts                  # Config graphiques recharts
```

Le mock data (`buildMockAgrieco`, `buildMockFiere`, `MOCK_DATA`) peut etre deplace dans un fichier `mock/` ou supprime.

---

## Tache 4 : Interface d'import Admin + Pipeline ETL (COMPLEXE - PRIORITE HAUTE)

C'est la tache la plus importante. C'est le chaînon manquant entre les données terrain et le dashboard/carto.

### Contexte : le flux réel des données terrain

```
Enquêteurs (smartphone Kobo/QField)
    ↓ collecte terrain
Superviseurs (editor) - TRAVAIL 100% HORS LIGNE
    ↓ téléchargent CSV depuis Kobo
    ↓ contrôlent dans Excel (check-list qualité)
    ↓ vérifient cartographie dans QGIS
    ↓ packagent ZIP (CSV nettoyé + README + journal)
    ↓ envoient par email/USB au chef d'équipe
Admins (N1/N2/global) - INTERFACE WEB SIG GN
    ↓ uploadent les CSV nettoyés via l'onglet Imports
    ↓ [ETL] données insérées dans stage.*
    ↓ [REFRESH] core.* et marts.* se mettent à jour
Dashboard + Cartographie
    ↓ affichent les indicateurs et couches
```

**Point clé** : Les superviseurs NE SE CONNECTENT PAS à la base de données. Ils travaillent sur leur PC local (Excel, QGIS) et transmettent des fichiers CSV nettoyés. C'est l'Admin SIG (via l'interface web) qui charge les données dans le système.

**Contrainte infra** : Le système tourne sur un serveur physique ENABEL à Kindia (pas de cloud). Tout est local.

### Scoping par rôle - QUI PEUT IMPORTER QUOI

| Rôle | Scope d'import | Exemple |
|---|---|---|
| `manager` (Admin N1) | Sa région + son projet uniquement | AGRIECO + Mamou seulement |
| `project_manager` (Admin N2) | Toutes régions de son projet | FIERE toutes régions |
| `admin` (Admin global) | Tous projets, toutes régions | Tout |

Le backend doit **vérifier le scope** : un manager FIERE/Kindia ne peut PAS importer des données AGRIECO/Mamou. Le middleware `CurrentProjectMiddleware` fournit déjà `request.current_project` et `request.current_region`.

### Etat actuel

- **Frontend** : `ImportsTab.tsx` est un **placeholder vide** ("En cours de mise en place")
- **Backend** : Aucun endpoint d'import CSV. Le `WorkflowSubmissionPublishView` (workflow_core/views.py:701-739) ne fait que changer le status à `PUBLISHED` sans ETL.
- **DB** : Les tables `stage.*` existent mais sont potentiellement incomplètes pour les données Kobo.

### 4a. Frontend - Interface d'import (`ImportsTab.tsx`)

**Fichier** : `sig-gn-frontend/app/(protected)/administration/tabs/imports/ImportsTab.tsx`

Fonctionnalités à implémenter :

1. **Sélecteur de dataset** : dropdown avec les types de données importables
   - AGRIECO : ménages, organisations, comités, parcelles CEP, zones dégradées, têtes de source, stations météo, intrants, ouvrages, couloirs, mesures météo, pratiques agro, marchés
   - FIERE : suivi sortants, emplois, insertions, entreprises, formations, acteurs
   - Les datasets disponibles dépendent du projet sélectionné (header X-Project-Code)

2. **Upload CSV** : zone drag-and-drop ou bouton parcourir
   - Accepter fichiers `.csv` uniquement
   - Encodage UTF-8, séparateur point-virgule (`;`) — c'est le format Kobo par défaut
   - Taille max : 10 MB

3. **Aperçu des données** : tableau preview des 10 premières lignes
   - Afficher les colonnes détectées
   - Mapping automatique colonnes CSV → colonnes stage (si possible)
   - Indicateurs : nombre de lignes, colonnes reconnues, colonnes inconnues

4. **Dry-run / validation** : bouton "Vérifier" avant import réel
   - Appel API POST `/api/proxy/import/validate/` avec le CSV
   - Retourne : erreurs de format, doublons potentiels, lignes invalides
   - L'admin peut corriger le CSV et re-uploader

5. **Import réel** : bouton "Importer" après validation
   - Appel API POST `/api/proxy/import/execute/`
   - Barre de progression (ou spinner)
   - Résultat : X lignes insérées, Y ignorées, Z erreurs

6. **Journal des imports** : tableau historique
   - Appel API GET `/api/proxy/import/log/`
   - Colonnes : date, utilisateur, dataset, projet, région, nb lignes, statut
   - Filtrable par date, dataset, statut

**Convention rappel** : utiliser `fetch` avec `credentials: "include"`, headers `X-SIG-Intent: 1` + `X-Project-Code`.

**Composants suggérés** :
```
imports/
  ImportsTab.tsx              # Orchestration principale
  components/
    DatasetSelector.tsx       # Dropdown dataset + description
    CsvUploader.tsx           # Zone upload + preview
    ValidationReport.tsx      # Résultat dry-run
    ImportHistory.tsx         # Journal des imports passés
  hooks/
    useImportApi.ts           # Appels API import
  config/
    datasetDefinitions.ts     # Liste datasets par programme avec colonnes attendues
```

### 4b. Backend - Endpoints d'import

**Nouvelle app Django** : `import_core` (à créer dans `sig-gn-backend/`)

1. **POST `/import/validate/`** — Dry-run
   - Reçoit : fichier CSV multipart + `dataset_code` + `project_code` + `region_id` (optionnel)
   - Vérifie le scope de l'utilisateur (N1/N2/admin)
   - Parse le CSV (séparateur `;`, encodage UTF-8)
   - Valide : colonnes obligatoires, types, formats GPS, doublons
   - Retourne : rapport de validation JSON (erreurs, warnings, stats)

2. **POST `/import/execute/`** — Import réel
   - Mêmes paramètres que validate
   - Re-valide (sécurité)
   - Insère dans `stage.{table}` via requêtes paramétrées (pas d'ORM, le schéma est externe)
   - Crée une entrée dans le journal d'import
   - Retourne : résultat (nb insérés, nb ignorés, erreurs)

3. **GET `/import/log/`** — Journal
   - Filtres : `project_code`, `region_id`, `dataset_code`, `date_from`, `date_to`
   - Scopé selon le rôle de l'utilisateur
   - Retourne : liste paginée des imports passés

4. **POST `/import/refresh-views/`** — Rafraîchir les vues matérialisées (admin uniquement)
   - Exécute `REFRESH MATERIALIZED VIEW` sur `core.*` puis `marts.*`
   - Utile après un gros import

**Fichiers backend à créer** :
```
sig-gn-backend/import_core/        # Nouvelle app Django
  __init__.py
  apps.py
  models.py                        # ImportLog model
  views.py                         # Validate, Execute, Log, RefreshViews
  serializers.py                   # ImportLogSerializer
  permissions.py                   # ScopeCheck (region + projet selon rôle)
  csv_parser.py                    # Parse et validation CSV
  etl.py                           # Mapping CSV → stage tables
  urls.py                          # Routes /import/...
  tests.py                         # Tests avec SimpleTestCase + mocks
```

Ajouter dans `config/urls.py` :
```python
path("import/", include("import_core.urls")),
```

Ajouter `"import_core"` dans `INSTALLED_APPS` de `config/settings.py`.

### 4c. Mapping CSV → Tables stage

Les fichiers CSV Kobo ont des colonnes spécifiques. Exemples réels (extraits des livrables Jalon 2, dossier `Llivrable Jalon2/bases données géo/`) :

**AGRIECO - Ménages** (séparateur `;`, ~70 colonnes) :
```
_id; project_code; region; prefecture; sous_prefecture; district; localite;
nom_chef_menage; prenom_chef_menage; sexe_cm; age_cm; telephone;
nb_membres; nb_hommes; nb_femmes; nb_enfants;
activite_principale; source_revenu; type_habitat;
_gps_latitude; _gps_longitude; _gps_altitude;
_submission_time; _submitted_by; ...
```

**FIERE - Suivi sortants** (séparateur `;`, ~30 colonnes) :
```
_id; project_code; region; prefecture;
nom_sortant; prenom_sortant; sexe; age; telephone;
formation_suivie; date_sortie; statut_insertion;
type_emploi; secteur_activite; revenu_mensuel;
_submission_time; _submitted_by; ...
```

**Table cible** : `stage.{dataset}` — les colonnes stage doivent correspondre aux colonnes CSV nettoyées.

**Attention** :
- Les noms de colonnes Kobo peuvent varier selon la version du formulaire
- Le fichier `datasetDefinitions.ts` (frontend) et `etl.py` (backend) doivent lister les colonnes attendues
- Consulter `structure_sig_gn.txt` et `restore_list.txt` à la racine pour le schéma complet des tables stage
- Consulter les 16 CSV dans `Llivrable Jalon2/bases données géo/` pour les colonnes réelles
- Les 16 formulaires Kobo sont : 11 AGRIECO (ménages, organisations, comités, CEP parcelles, zones dégradées, têtes source, météo stations, intrants distribution, ouvrages hydrauliques, couloirs transhumance, marchés) + 5 FIERE (suivi sortants, emplois, insertions, entreprises, formations)

### 4d. Rafraîchissement des vues

Après insertion dans `stage.*`, les vues PostgreSQL doivent être rafraîchies :

```sql
-- Ordre : stage → core → marts
REFRESH MATERIALIZED VIEW CONCURRENTLY core.vue_menages;
REFRESH MATERIALIZED VIEW CONCURRENTLY core.vue_parcelles;
-- ... etc pour chaque vue core
REFRESH MATERIALIZED VIEW CONCURRENTLY marts.agr_menages;
REFRESH MATERIALIZED VIEW CONCURRENTLY marts.agr_organisations;
-- ... etc pour chaque vue marts
```

**Note** : Les noms exacts des vues sont dans `structure_sig_gn.txt`. Vérifier quelles vues sont matérialisées (`MATERIALIZED VIEW`) vs simples (`VIEW`). Les vues simples se mettent à jour automatiquement.

### 4e. Sécurité et permissions

- **Scope obligatoire** : Vérifier que l'utilisateur a le droit d'importer pour le projet/région cible
- **Validation CSV** : Pas d'injection SQL via les données CSV (utiliser des requêtes paramétrées, JAMAIS de f-string SQL)
- **Taille fichier** : Limiter à 10 MB côté backend aussi (pas seulement frontend)
- **Rate limiting** : Appliquer le throttle existant (`accounts/throttles.py`)
- **Audit** : Logger chaque import avec utilisateur, timestamp, dataset, résultat
- **Pattern existant** : Suivre le même pattern que `admin_core/` pour les permissions scope (voir `admin_core/views.py`)

---

## Tache 5 : Mettre a jour documentation_ch.md

Apres chaque modification, ajouter une section numerotee (continuer a partir de **section 57**) dans `documentation_ch.md` avec :
- Objectif
- Fichiers modifies
- Verification executee
- Etat

---

## Priorite recommandee

1. **Tache 4 (Import + ETL)** — PRIORITE 1 — C'est le besoin fonctionnel principal
2. Tache 1 (nettoyage) — 5 min, peut être fait en parallèle
3. Tache 2 (découpe workflow) — 30-60 min, amélioration maintenabilité
4. Tache 3 (découpe dashboard) — 30-60 min, amélioration maintenabilité
5. Tache 5 (doc) — au fil de l'eau

## Reference

- Documentation complète : `C:\xampp\htdocs\sig_gn\documentation_ch.md` (56 sections, ~2287 lignes)
- Mémoire projet : `C:\Users\elmoh\.claude\projects\C--xampp-htdocs-sig-gn\memory\MEMORY.md`
- Schéma DB : `C:\xampp\htdocs\sig_gn\structure_sig_gn.txt` et `restore_list.txt`
- CSV exemples réels : `C:\xampp\htdocs\sig_gn\Llivrable Jalon2\bases données géo\*.csv`
- Check-lists superviseurs : `C:\xampp\htdocs\sig_gn\Llivrable Jalon2\Check-list *.pdf`
- Procédure analystes : `C:\xampp\htdocs\sig_gn\Llivrable Jalon2\Procédure *.pdf`

