from django.contrib.auth import authenticate

from rest_framework import generics, permissions, status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken

from .serializers import (
    CurrentUserSerializer,
    RefProjectSerializer,
    SignupSerializer,
    LoginSerializer,
)


class SignupView(generics.CreateAPIView):
    serializer_class = SignupSerializer
    permission_classes = [permissions.IsAdminUser]


class LoginView(APIView):
    permission_classes = [permissions.AllowAny]
    serializer_class = LoginSerializer  # pour drf-spectacular

    def post(self, request, *args, **kwargs):
        serializer = LoginSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        username = serializer.validated_data["username"]
        password = serializer.validated_data["password"]

        user = authenticate(request, username=username, password=password)

        if user is None:
            return Response(
                {"detail": "Identifiants invalides."},
                status=status.HTTP_401_UNAUTHORIZED,
            )

        if not user.is_active:
            return Response(
                {"detail": "Compte désactivé."},
                status=status.HTTP_403_FORBIDDEN,
            )

        refresh = RefreshToken.for_user(user)
        user_data = CurrentUserSerializer(user, context={"request": request}).data

        return Response(
            {
                "access": str(refresh.access_token),
                "refresh": str(refresh),
                "user": user_data,
            },
            status=status.HTTP_200_OK,
        )


class MeView(APIView):
    permission_classes = [IsAuthenticated]
    serializer_class = CurrentUserSerializer  # pour drf-spectacular

    def get(self, request):
        serializer = CurrentUserSerializer(request.user)
        return Response(serializer.data)


class CurrentProjectView(APIView):
    permission_classes = [IsAuthenticated]
    serializer_class = RefProjectSerializer  # pour drf-spectacular

    def get(self, request):
        project = getattr(request, "current_project", None)
        if project is None:
            return Response({"detail": "Aucun projet actif"}, status=400)

        serializer = RefProjectSerializer(project)
        return Response(serializer.data)
