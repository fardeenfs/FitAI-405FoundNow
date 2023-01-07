from django.db import models

# Create your models here.
from django.contrib.auth.base_user import BaseUserManager
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils.translation import gettext_lazy as _


class CustomUserManager(BaseUserManager):

    def create_user(self, email, password, **extra_fields):
        if not email:
            raise ValueError(_('The Email must be set'))
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save()
        return user

    def create_superuser(self, email, password, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('is_active', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError(_('Superuser must have is_staff=True.'))
        if extra_fields.get('is_superuser') is not True:
            raise ValueError(_('Superuser must have is_superuser=True.'))
        return self.create_user(email, password, **extra_fields)


class CustomUser(AbstractUser):
    username = None
    email = models.EmailField(_('email address'), unique=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    objects = CustomUserManager()

    def __str__(self):
        return self.email


class UserProfile(models.Model):
    email = models.EmailField(unique=True)
    name = models.TextField()
    birthday = models.DateField(default='2001-01-01')
    height = models.DecimalField(decimal_places=2,max_digits=5)
    weight = models.DecimalField(decimal_places=2,max_digits=5)
    bmi = models.DecimalField(decimal_places=2,max_digits=5)

    def calculate_bmi(self):
        bmi = self.weight / (self.height ** 2)
        return bmi

    def save(self, *args, **kwargs):
        self.bmi = self.calculate_bmi()
        super(UserProfile, self).save(*args, **kwargs)
