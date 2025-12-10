from rest_framework import serializers

from .models import User, RefProject


class RefProjectSerializer(serializers.ModelSerializer):
    class Meta:
        model = RefProject
        fields = [
            "project_id",
            "code_fonc",
            "libelle_public",
            "actif",
        ]


class CurrentUserSerializer(serializers.ModelSerializer):
    """
    Sérialisation de l'utilisateur courant pour le front :
    - infos de base
    - rôle
    - liste des projets
    """

    projects = RefProjectSerializer(many=True, read_only=True)

    class Meta:
        model = User
        fields = [
            "id",
            "username",
            "first_name",
            "last_name",
            "email",
            "role",
            "projects",
        ]


class SignupSerializer(serializers.ModelSerializer):
    """
    Utilisé pour l'endpoint /api/accounts/signup/

    Par défaut, on réserve cet endpoint aux admins (cf. views.py).
    """

    password = serializers.CharField(write_only=True, min_length=8)

    # L'admin peut rattacher directement des projets à l'utilisateur
    projects = serializers.PrimaryKeyRelatedField(
        queryset=RefProject.objects.all(),
        many=True,
        required=False,
    )

    class Meta:
        model = User
        fields = [
            "username",
            "first_name",
            "last_name",
            "email",
            "password",
            "role",
            "projects",
        ]
        extra_kwargs = {
            "role": {"required": False},
        }

    def create(self, validated_data):
        projects = validated_data.pop("projects", [])
        password = validated_data.pop("password")

        user = User(**validated_data)
        user.set_password(password)
        user.save()

        if projects:
            user.projects.set(projects)

        return user


class LoginSerializer(serializers.Serializer):
    """
    Payload attendu pour /api/accounts/login/ :

    {
      "username": "....",
      "password": "...."
    }
    """

    username = serializers.CharField()
    password = serializers.CharField(write_only=True)
