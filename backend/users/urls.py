from django.urls import path
from rest_framework_simplejwt.views import TokenRefreshView

from users.views import EmailTokenObtainPairView, RegisterView, ProfileView

urlpatterns = [
    path('register/', RegisterView.as_view(), name='token_obtain_pair'),
    path('token/obtain/', EmailTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('user-profile/', ProfileView.as_view(), name='User Profile')
]