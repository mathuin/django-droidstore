from django.conf.urls import url
from store import views as store_views

urlpatterns = [
    url(r'^$', store_views.home, name='store_home'),
]
