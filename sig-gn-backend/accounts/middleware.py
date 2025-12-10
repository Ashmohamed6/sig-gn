from django.utils.deprecation import MiddlewareMixin
from django.conf import settings

from .models import RefProject


class CurrentProjectMiddleware(MiddlewareMixin):
    """
    Récupère le projet actif à partir du header HTTP 'X-Project-Code'
    et l'attache à request.current_project.

    - Ne s'applique qu'aux URLs qui commencent par /api/
    - Si l'utilisateur n'est pas authentifié : ne fait rien.
    - Si aucun header n'est fourni : prend le premier projet actif de l'utilisateur.
    - Si le projet n'appartient pas à l'utilisateur : current_project = None.
    """

    def process_request(self, request):
        # On ne touche pas à l'admin, etc.
        if not request.path.startswith("/api/"):
            return

        user = getattr(request, "user", None)
        request.current_project = None

        if not user or not user.is_authenticated:
            return

        # Clé utilisée dans request.META
        meta_header = getattr(settings, "CURRENT_PROJECT_HEADER", "HTTP_X_PROJECT_CODE")

        code = request.META.get(meta_header)
        project = None

        if code:
            try:
                # On identifie le projet par son code fonctionnel (FIERE / AGRIECO)
                project = RefProject.objects.get(code_fonc=code, actif=True)
            except RefProject.DoesNotExist:
                project = None
        else:
            # Pas de header : projet par défaut = 1er projet actif de l'utilisateur
            project = (
                user.projects.filter(actif=True)
                .order_by("code_fonc")
                .first()
            )

        # On ne garde que si le projet appartient bien à l'utilisateur
        if project and not user.projects.filter(project_id=project.project_id).exists():
            project = None

        request.current_project = project
