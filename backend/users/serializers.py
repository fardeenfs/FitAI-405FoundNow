from django.contrib.auth import get_user_model
from rest_framework import serializers, request
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer as JwtTokenObtainPairSerializer
from users.models import UserProfile


class TokenObtainPairSerializer(JwtTokenObtainPairSerializer):
    username_field = get_user_model().USERNAME_FIELD


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = get_user_model()
        fields = ('email', 'password')


class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = '__all__'

class ProfileAddSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ('name','height','weight','email')