from datetime import datetime, timedelta

from django.forms import model_to_dict
from django.http import JsonResponse
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
        now = datetime.now()
        start_date = now - timedelta(days=6)
        end_date = now - timedelta(days=1)
        data_set = []
        while start_date != end_date:
            data = WorkoutActivityTrack.objects.filter(
                workout_date=start_date, user_id=user_id, workout_type_id=0
            )
            if len(data) > 0:
                data = model_to_dict(data[0])
                data.pop("user_id")
                data.pop("id")
                data_set.append(data)
            else:
                empty_set = {"workout_type_id": 0,
                             "workout_count": 0,
                             "workout_date": start_date.strftime('%Y-%m-%d'),
                             "calorie_burnt": 0,
                             "mins": 0}
                data_set.append(empty_set)
            data = WorkoutActivityTrack.objects.filter(
                workout_date=start_date, user_id=user_id, workout_type_id=1
            )
            if len(data) > 0:
                data = model_to_dict(data[0])
                data.pop("user_id")
                data.pop("id")
                data_set.append(data)
            else:
                empty_set = {"workout_type_id": 1,
                             "workout_count": 0,
                             "workout_date": start_date.strftime('%Y-%m-%d'),
                             "calorie_burnt": 0,
                             "mins": 0}
                data_set.append(empty_set)
            start_date += timedelta(days=1)
        # serializer = self.serializer_class(data, many=True)
        return JsonResponse(data_set,safe=False)

    def post(self, request):
        email = request.user.email
        user_id = UserProfile.objects.get(email=email).id
        data = request.data.copy()
        data["user_id"] = user_id
        data['calorie_burnt'] = 1
        data['mins'] = 1
        post_serializer = self.serializer_class(data=data)
        if post_serializer.is_valid():
            post_serializer.save()
            return Response(post_serializer.data)
        return Response(status=HTTP_400_BAD_REQUEST, data={'errors': post_serializer.errors})
