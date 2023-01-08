import decimal

from django.db import models
from users.models import UserProfile


class WorkoutType(models.Model):
    workout_type_id = models.BigIntegerField()
    workout_name = models.TextField()
    met_value = models.DecimalField(max_digits=9, decimal_places=2)
    avg_count_per_min = models.IntegerField()


class WorkoutActivityTrack(models.Model):
    user_id = models.BigIntegerField()
    workout_type_id = models.BigIntegerField()
    workout_count = models.IntegerField()
    workout_date = models.DateField()
    calorie_burnt = models.BigIntegerField()
    mins = models.BigIntegerField()

    def calculate_mins(self):
        workout_type = WorkoutType.objects.get(workout_type_id=self.workout_type_id)

        return int(self.workout_count / workout_type.avg_count_per_min)

    def calculate_calorie_burnt(self):
        workout_type = WorkoutType.objects.get(workout_type_id=self.workout_type_id)
        user = UserProfile.objects.get(pk=self.user_id)
        calorie_burnt = int(decimal.Decimal(0.175) * decimal.Decimal(workout_type.met_value) *
                            decimal.Decimal(user.weight) * int(self.workout_count / workout_type.avg_count_per_min))
        return calorie_burnt

    def save(self, *args, **kwargs):
        self.calorie_burnt = self.calculate_calorie_burnt()
        self.mins = self.calculate_mins()
        prev = UserRankingSystem.objects.filter(user_id=self.user_id, workout_type_id=self.workout_type_id)
        if len(prev) == 0:
            UserRankingSystem.objects.create(
                user_id=self.user_id,
                workout_type_id=self.workout_type_id,
                workout_total_count=self.workout_count,
                workout_days_count=1,
            )
        else:
            obj = prev[0]
            obj.workout_total_count += self.workout_count
            obj.workout_days_count += 1
            obj.save()
        super(WorkoutActivityTrack, self).save(*args, **kwargs)


class UserRankingSystem(models.Model):
    user_id = models.BigIntegerField()
    workout_type_id = models.BigIntegerField()
    workout_total_count = models.BigIntegerField()
    workout_days_count = models.BigIntegerField()
    avg_count_per_day = models.BigIntegerField()

    def calculate_avg_count_per_day(self):
        avg_count_per_day = self.workout_total_count / self.workout_days_count
        return avg_count_per_day

    def save(self, *args, **kwargs):
        self.avg_count_per_day = self.calculate_avg_count_per_day()
        super(UserRankingSystem, self).save(*args, **kwargs)
