from django.urls import path
from rest_framework_simplejwt.views import TokenRefreshView

from workout_plan.views import WorkoutActivityTrackView, WorkoutTypeView

urlpatterns = [
    path('activity/', WorkoutActivityTrackView.as_view(), name='workout activity track'),
    path('types/', WorkoutTypeView.as_view(), name='available workout types'),
]