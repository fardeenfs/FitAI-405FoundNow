from datetime import datetime, timedelta

from django.shortcuts import render
from rest_framework import views
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.status import HTTP_400_BAD_REQUEST
from rest_framework_simplejwt.authentication import JWTAuthentication

from users.models import UserProfile
from workout_plan.models import WorkoutActivityTrack, WorkoutType
from workout_plan.serializers import WorkoutTypeSerializer, WorkoutActivityTrackSerializer


# Create your views here.
class WorkoutTypeView(views.APIView):
    authentication_classes = []
    permission_classes = [AllowAny]
    serializer_class = WorkoutTypeSerializer

    def get(self, request):
        workout_types = WorkoutType.objects.all()
        serializer = WorkoutTypeSerializer(workout_types, many=True)
        return Response(serializer.data)


class WorkoutActivityTrackView(views.APIView):
    authentication_classes = [JWTAuthentication]
    serializer_class = WorkoutActivityTrackSerializer

    def get(self, request):
        email = request.user.email
        user_id = UserProfile.objects.get(email=email).id
        data = WorkoutActivityTrack.objects.filter(
            workout_date__gte=datetime.now() - timedelta(days=7),
            workout_date__lt=datetime.now(), user_id=user_id
        )
        serializer = self.serializer_class(data, many=True)
        return Response(serializer.data)

    def post(self, request):
        email = request.user.email
        user_id = UserProfile.objects.get(email=email).id
        data = request.data.copy()
        data["user_id"] = user_id
        data['calorie_burnt'] = 1
        post_serializer = self.serializer_class(data=data)
        if post_serializer.is_valid():
            post_serializer.save()
            return Response(post_serializer.data)
        return Response(status=HTTP_400_BAD_REQUEST, data={'errors': post_serializer.errors})

