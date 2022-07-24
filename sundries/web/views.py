# -*- coding: utf-8 -*-
from django.shortcuts import render, HttpResponseRedirect
from django.http import HttpRequest, HttpResponse
from django.core.mail import send_mail
from django.http import Http404   #, request
# from web.models import TbContent, TbCategory, TbPoint
# from web.add_function import *
# from rsvo_new.settings import *
# import smtplib


def index(request: HttpRequest) -> HttpResponse:
    """ страница УПАК РСВО

    :param request:
    :return:  response:
    """
    template = "tmp.jinja2"  # шаблон
    to_template = {}
    # to_template = {"COOKIES": check_cookies(request)}
    return render(request, template, to_template)
