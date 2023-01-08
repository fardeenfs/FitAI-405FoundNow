from django.contrib.auth import get_user_model
from rest_framework import serializers, request
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer as JwtTokenObtainPairSerializer
from workout_plan.models import UserRankingSystem, WorkoutType, WorkoutActivityTrack


class WorkoutActivityTrackSerializer(serializers.ModelSerializer):
    class Meta:
        model = WorkoutActivityTrack
        fields = '__all__'


class WorkoutTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = WorkoutType
        fields = '__all__'


class UserRankingSystemSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserRankingSystem
        fields = '__all__'
