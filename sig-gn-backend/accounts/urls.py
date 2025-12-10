from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

from .views import (
    MeView,
    CurrentProjectView,
    LoginView,
    SignupView,
)

urlpatterns = [
    # --- Auth applicative "confort" (login + user) ---
    path("login/", LoginView.as_view(), name="accounts_login"),
    path("signup/", SignupView.as_view(), name="accounts_signup"),

    # --- Auth JWT "classique" ---
    path("token/", TokenObtainPairView.as_view(), name="accounts_token_create"),
    path("token/refresh/", TokenRefreshView.as_view(), name="accounts_token_refresh"),

    # --- User courant & projet actif ---
    path("me/", MeView.as_view(), name="accounts_me"),
    path("current-project/", CurrentProjectView.as_view(), name="accounts_current_project"),
]
