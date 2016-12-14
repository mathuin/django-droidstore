# Create your views here.
from django.shortcuts import render
from store.models import Product


def home(request, template_name='store.djhtml'):
    products = Product.objects.all()

    return render(request, template_name, locals())
