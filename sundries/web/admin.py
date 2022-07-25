# -*- coding: utf-8 -*-
from django.contrib import admin
from django.db import models
from django.forms import TextInput, Textarea
from taggit.managers import TaggableManager
from web.models import TbContentItem, TbImage
from web.add_function import safe_html_special_symbols


# Register your models here.
class AdminContent(admin.ModelAdmin):
    search_fields = ['szContentTitle', 'szContentText', 'szContentSlug']
    list_display = ('id', 'ContentTitleSafe', 'tag_list', 'bContentPublish',
                    'kUser', 'dtContentCreate', 'kContentItemEdited')
    list_display_links = ('id', 'ContentTitleSafe')
    list_filter = ('bContentPublish', 'kUser')
    list_editable = ('bContentPublish', )
    # настройка длины поля TextInput в админке
    formfield_overrides = {
        models.CharField: {'widget': TextInput(attrs={'size': '80%'})},
        TaggableManager: {'widget': TextInput(attrs={'size': '80%'})},
        # models.TextField: {'widget': Textarea(attrs={'rows': 4, 'cols': 40})},
    }
    # Настройка страницы редактирования
    fieldsets = [
        (None, {
            'fields': ('kImages', ('bContentPublish', 'szContentTitle',), 'szContentText', 'tags')
        }),
        ('Типограф, Slug, User, Цепочка редактирования', {
            'fields': ('bContentTypograf', 'szContentSlug', 'kUser', 'kContentItemEdited'),
            'classes': ('collapse',),
        }),
    ]
    # exclude = ('', '', )
    empty_value_display = u"<b style='color:red;'>—//—</b>"
    actions_on_top = False
    actions_on_bottom = False

    def ContentTitleSafe(self, obj) -> str:
        return safe_html_special_symbols(obj.szContentTitle)

    # def original(self, obj) -> str:
    #     if self.

    def get_queryset(self, request):
        return super().get_queryset(request).prefetch_related('tags')

    def tag_list(self, obj):
        return ", ".join(o.name for o in obj.tags.all())


class AdminImage(admin.ModelAdmin):
    list_display = ('id', 'flrImage', 'iSort', 'tag_list', 'bImagePublish')
    list_display_links = ('id', 'flrImage')
    list_editable = ('bImagePublish', )
    formfield_overrides = {
        TaggableManager: {'widget': TextInput(attrs={'size': '80%'})},
    }

    def get_queryset(self, request):
        return super().get_queryset(request).prefetch_related('tags')

    def tag_list(self, obj):
        return ", ".join(o.name for o in obj.tags.all())


admin.site.register(TbContentItem, AdminContent)
admin.site.register(TbImage, AdminImage)
