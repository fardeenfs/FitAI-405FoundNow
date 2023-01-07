from django.shortcuts import render

from django.contrib.auth import get_user_model
from rest_framework.response import Response
from rest_framework.status import HTTP_201_CREATED, HTTP_400_BAD_REQUEST
from rest_framework import views
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework_simplejwt.authentication import JWTAuthentication

from users.models import UserProfile
from users.serializers import UserSerializer, TokenObtainPairSerializer, ProfileSerializer, ProfileAddSerializer


class RegisterView(views.APIView):
    http_method_names = ['post']

    def post(self, *args, **kwargs):
        serializer = UserSerializer(data=self.request.data)
        if serializer.is_valid():
            get_user_model().objects.create_user(**serializer.validated_data)
            return Response(status=HTTP_201_CREATED)
        return Response(status=HTTP_400_BAD_REQUEST, data={'errors': serializer.errors})


class EmailTokenObtainPairView(TokenObtainPairView):
    serializer_class = TokenObtainPairSerializer


class ProfileView(views.APIView):
    authentication_classes = [JWTAuthentication]
    serializer_class = ProfileSerializer

    def get(self, request):
        email = request.user.email
        profile = UserProfile.objects.get(email=email)
        serializer = self.serializer_class(profile)
        return Response(serializer.data)

    def put(self, request):
        email = request.user.email
        profile = UserProfile.objects.get(email=email)
        data = request.data.copy()
        data['email'] = email
        data['bmi'] = 1
        serializer = self.serializer_class(profile, data=data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(status=HTTP_400_BAD_REQUEST, data={'errors': serializer.errors})

    def post(self, request):
        email = request.user.email
        data = request.data.copy()
        data['email'] = email
        data['bmi'] = 1
        post_serializer = ProfileSerializer(data=data)
        if post_serializer.is_valid():
            post_serializer.save()
            return Response(post_serializer.data)
        return Response(status=HTTP_400_BAD_REQUEST, data={'errors': post_serializer.errors})
