from django.contrib import admin

from workout_plan.models import WorkoutType, WorkoutActivityTrack, UserRankingSystem

# Register your models here.
admin.site.register(WorkoutType)
admin.site.register(WorkoutActivityTrack)
admin.site.register(UserRankingSystem)