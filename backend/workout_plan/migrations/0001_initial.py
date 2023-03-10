# Generated by Django 4.1.5 on 2023-01-08 06:04

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='UserRankingSystem',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_id', models.BigIntegerField()),
                ('workout_type_id', models.BigIntegerField()),
                ('workout_total_count', models.BigIntegerField()),
                ('workout_days_count', models.BigIntegerField()),
                ('avg_count_per_day', models.BigIntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='WorkoutActivityTrack',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_id', models.BigIntegerField()),
                ('workout_type_id', models.BigIntegerField()),
                ('workout_count', models.IntegerField()),
                ('workout_date', models.DateField()),
            ],
        ),
        migrations.CreateModel(
            name='WorkoutType',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('workout_type_id', models.BigIntegerField()),
                ('workout_name', models.TextField()),
                ('met_value', models.TextField()),
                ('avg_count_per_min', models.IntegerField()),
            ],
        ),
    ]
