# -*- coding: utf-8 -*-
import random
from django.db import models
from django.contrib.auth.models import User
from django.utils.timezone import now
from filer.fields.image import FilerFileField
from taggit.models import Tag, TaggedItem
from taggit.managers import TaggableManager
from ckeditor.fields import RichTextField
# from ckeditor_uploader.fields import RichTextUploadingField
from sundries.settings import *
from web.add_function import safe_html_special_symbols
import pytils
# import datetime
# import urllib3
# import json


# МАГИЯ: класс для транслитерации русскоязычных slug
# рецепт взят отсюда: https://timonweb.com/django/russian-slugs-for-django-taggit/
class RuTag(Tag):
    class Meta:
        proxy = True

    def slugify(self, tag, i=None):
        return pytils.translit.slugify(self.name.lower())[:128]


class RuTaggedItem(TaggedItem):
    class Meta:
        proxy = True

    @classmethod
    def tag_model(cls):
        return RuTag


class TbImage(models.Model):
    # ============================================================
    # ТАБЛИЦА TbImage (КАРТИНКИ)
    # ------------------------------------------------------------
    # | id               -- id | primarykey INT(11) / NOT NULL AUTO_INCREMENT) |
    # | bImagePublish    -- опубликовано или нет | tinyint(1) / NOT NULL |
    # | iSort            -- сортировка | int(11) / NOT NULL |
    # | flrImage_id      -- ссылка на картинку из filer | int(11) / DEFAULT NULL |
    # | dtImageTimeStamp -- штамп времени (скрытое поле) | datetime(6) / NOT NULL |
    # ============================================================
    bImagePublish = models.BooleanField(
        default=True,
        verbose_name=u'Опубликовано',
        help_text=u'Опубликовано или нет'
    )
    flrImage = FilerFileField(
        null=True, blank=True, on_delete=models.SET_NULL,
        related_name="IMG",
        verbose_name="IMG",
        help_text="Картинка"
    )
    tags = TaggableManager(
        blank=True,
        through=RuTaggedItem,
        verbose_name=u"Теги",
        help_text=u"Теги через запятую… Регистр не чувствителен… Длинные теги, содержащие пробел, заключайте"
                  u"'в кавычки'… <b>Теги нужны для присвоения свойств объектам<b>."
    )
    iSort = models.IntegerField(
        null=False,
        default=0,
        verbose_name="Порядок",
        help_text="Порядок вывода картинки в контенте"
    )
    dtImageTimeStamp = models.DateTimeField(
        auto_now=True,  # надо указать False при миграции, после вернуть в True
        # для выполнения миграций нужно добавлять default, а после она не нужна
        # default=datetime.datetime.now(pytz.timezone(settings.TIME_ZONE)),
        verbose_name="Штамп времени"
    )

    def __unicode__(self):
        return u"%02d: %s (%s)" % (self.id, self.flrImage.name, self.flrImage.file.size)

    def __str__(self):
        return u"%02d: %s" % (self.id, self.flrImage.name)

    class Meta:
        verbose_name = "[…Изображение]"
        verbose_name_plural = "[…Изображения]"
        ordering = ['id']


class TbContentItem(models.Model):
    # ============================================================
    # ТАБЛИЦА TbContentItem (КОНТЕНТ)
    # ------------------------------------------------------------
    # | id                    -- id | primarykey int(11) / NOT NULL AUTO_INCREMENT |
    # | bContentPublish       --tinyint(1) NOT NULL,
    # | szContentTitle        -- varchar(255) NOT NULL,
    # | szContentText         -- longtext NOT NULL,
    # | szContentSlug         -- слаг (с транслитерацией, уникальный) для заголовка | varchar(255) NOT NULL,
    # | bContentTypograf      -- конетент надо пропустить через типограф до сохранения | tinyint(1) NOT NULL |
    # | kUser_id              -- ссылка на пользователя из django.contrib.auth.models.User | int(11) DEFAULT NULL |
    # | kContentItemEdited_id -- ссылка контент-родитель (на саму себя) | int(11) DEFAULT NULL |
    # | dtContentCreate       -- дата публикации | datetime(6) NOT NULL |
    # | dtContentTimeStamp    -- штамп времени | datetime(6) NOT NULL |
    # ============================================================
    kUser = models.ForeignKey(
        User,
        null=True, blank=True, default=None,
        on_delete=models.SET_NULL,
        verbose_name=u"Пользователь",
        help_text=u"Пользователь, который добавил контент"
    )
    bContentPublish = models.BooleanField(
        default=True,
        verbose_name=u'Опубликовано',
        help_text=u'Опубликовано или нет'
    )
    kImages = models.ManyToManyField(
        'TbImage',
        null=True, blank=True,
        verbose_name=u"Картинка",
        help_text=u"Картинка привязанная к контенту (к одной единице контента может быть привязано несколько картинок)"
    )
    szContentTitle = models.CharField(
        max_length=255,
        verbose_name=u'Заголовок',
        help_text=u'Заголовок контента'
    )
    szContentText = RichTextField(
        config_name='fine',
        blank=True, default="",
        verbose_name="Содержание",
        help_text="Содержание <b>БЕЗ АНОНСА</b> <small>(допустим HTML-код, будет обработан типографом,"
                  " если его включить)</small>"
    )
    tags = TaggableManager(
        blank=True,
        through=RuTaggedItem,
        verbose_name=u"Теги",
        help_text=u"Теги через запятую… Регистр не чувствителен… Длинные теги, содержащие пробел, заключайте"
                  u"'в кавычки'… <b>Теги нужны для присвоения свойств объектам<b>."
    )
    szContentSlug = models.SlugField(
        max_length=255, unique=True, db_index=True,
        verbose_name=u'slud',
        help_text=u'Слаг  (транслитерация) контента'
    )
    bContentTypograf = models.BooleanField(
        default=False,
        verbose_name=u'Типографировать',
        help_text="Обработать через <a href=\"https://www.typograf.ru\""
                  " target=\"_blank\">Типограф 2.0</a>. Он умеет:<br />"
                  "&laquo;приклеивает&raquo; союзы, поддерживает неразрывные конструкции, "
                  "замена тире, перобразует кавычки и дефисы, расставляет &laquo;мягкие переносы&raquo; "
                  "в словах длиннее 12 символов, убирает &laquo;вдовы&raquo; &laquo;сироты&raquo; (кроме "
                  "заголовков), расставляет абзацы (кроме заголовков), расшифровывает "
                  "аббревиатуры (те, что знает и кроме заголовков), висячая "
                  "пунктуация тоже поддерживается и многое другое.</small>"
    )
    kContentItemEdited = models.ForeignKey(
        "TbContentItem",
        null=True, blank=True, default=None,
        on_delete=models.SET_NULL,
        verbose_name=u"Контент-родитель",
        help_text=u"Этот контент образовал от контент-родителя"
    )
    dtContentCreate = models.DateTimeField(
        auto_now_add=True,  # надо указать False при миграции, после вернуть в True
        verbose_name=u'Дата создания',
        help_text=u'Дата создания контента'
    )
    dtContentTimeStamp = models.DateTimeField(
        auto_now=True,      # надо указать False при миграции, после вернуть в True
        verbose_name="Штамп времени"
    )

    def save(self, *args, **kwargs):
        # переопределяем метод save для присвоения слага и типографирования заголовка и контента
        if self.szContentSlug is None or self.szContentSlug == "" or " " in self.szContentSlug:
            # если нет слага или в нем пробел, то генерируем слаг
            result_slug = pytils.translit.slugify(
                safe_html_special_symbols(self.szContentTitle)).lower()
            while TbContentItem.objects.filter(szContentSlug=result_slug).count() != 0:
                # если в таблице уже существует контент с таким же слагом, то заменяем последние две буквы
                # на случайное число и проверяем еще раз
                result_slug = "%s-%x" % (result_slug[0: -3], int(random.uniform(0, 255)))
            self.szContentSlug = result_slug
        # Присвоим имя пользователя создавшего контент
        # if self.kUser == "" or self.kUser.id is None or self.kUser.id == 0:
        #     self.kUser.id = request.user.id
        super(TbContentItem, self).save(*args, **kwargs)

    def __unicode__(self):
        result = safe_html_special_symbols(self.szContentTitle)
        return u"%03d: %s" % (self.id, result[:29] + "…" if len(result) > 30 else result)

    def __str__(self):
        result = safe_html_special_symbols(self.szContentTitle)
        return u"%03d: %s" % (self.id, result[:49] + "…" if len(result) > 50 else result)

    class Meta:
        verbose_name = "[…Контент]"
        verbose_name_plural = "[…Контент]"
        ordering = ['id']
