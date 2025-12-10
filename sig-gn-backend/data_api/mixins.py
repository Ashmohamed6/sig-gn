from rest_framework.response import Response
from rest_framework import status


class CurrentProjectRequiredMixin:
    """
    Ajoute une méthode utilitaire pour récupérer le projet actif.
    À utiliser dans les vues API (héritées de APIView ou GenericAPIView).
    """

    def get_current_project(self, request):
        project = getattr(request, "current_project", None)
        if project is None:
            # On pourrait lever une exception DRF, mais pour l'instant on renvoie une réponse simple.
            return None, Response(
                {"detail": "Aucun projet actif (header X-Project-Code manquant ou invalide)."},
                status=status.HTTP_400_BAD_REQUEST,
            )
        return project, None
