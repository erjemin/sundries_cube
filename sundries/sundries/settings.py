"""
Django settings for sundries project.

Generated by 'django-admin startproject' using Django 4.0.4.

For more information on this file, see
https://docs.djangoproject.com/en/4.0/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/4.0/ref/settings/
"""

from pathlib import Path
from sundries.my_secret import *
import socket

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/4.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = MY_SECRET_KEY

# SECURITY WARNING: don't run with debug turned on in production!
# ПРЕДУПРЕЖДЕНИЕ БЕЗОПАСНОСТИ: не работайте в режиме DEBUG в продашене!
if socket.gethostname() in MY_HOST_DEV:
    DEBUG = True
else:
    # Все остальные хосты (подразумевается продакшн)
    DEBUG = False


# Хосты на которых может работать приложение
ALLOWED_HOSTS = MY_ALLOWED_HOSTS

# Настройки сообщений об ошибках когда все упало и т.п.
ADMINS = (
    ('S.Erjemin', 'erjemin@gmail.com'),
)

# Application definition
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'easy_thumbnails',
    'filer.apps.FilerConfig',
    'mptt.apps.MpttConfig',
    'ckeditor',
    'taggit.apps.TaggitAppConfig',
    'web',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'sundries.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.jinja2.Jinja2',
        'DIRS': [BASE_DIR / 'templates-jinja2'],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
            'environment': 'sundries.my_jinja2_addon.environment',
            'extensions': [
                'sundries.my_jinja2_addon.DjangoNow',
                ],
        },
    }, {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [BASE_DIR / 'templates'],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'sundries.wsgi.application'

# Password validation
# https://docs.djangoproject.com/en/4.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator', },
    {'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator', },
    {'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator', },
    {'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator', },
]


# Internationalization
# https://docs.djangoproject.com/en/4.0/topics/i18n/
LANGUAGE_CODE = 'ru-RU'
TIME_ZONE = 'Europe/Moscow'
USE_I18N = True
USE_TZ = True
USE_L10N = True                 # локальный формат дат имеет приоритет
FIRST_DAY_OF_WEEK = 1           # 1'st day week -- monday
SHORT_DATE_FORMAT = '%Y-%m-%d'
SHORT_DATETIME_FORMAT = '%Y-%m-%d %H:%M:%S'

# Security
SECURE_CONTENT_TYPE_NOSNIFF: bool = True  # устанавливает заголовок X-Content-Type-Options: nosniff

# настройки THUMBNAIL (батарейка по созданию превьюшек)
THUMBNAIL_HIGH_RESOLUTION: bool = True  # Для easy_thumbnails поддержки retina-дисплеев (MacBooks, iOS и т.п.)
THUMBNAIL_PROCESSORS = (
    'easy_thumbnails.processors.colorspace',
    'easy_thumbnails.processors.autocrop',
    #'easy_thumbnails.processors.scale_and_crop',
    'filer.thumbnail_processors.scale_and_crop_with_subject_location',
    'easy_thumbnails.processors.filters',
)
THUMBNAIL_ALIASES: dict = {
    '': {
        'x64': {'size': (64, 64), 'crop': True},
        'x680': {'size': (680, 680), 'crop': True},
        'x1140': {'size': (1140, 1140), 'crop': True},
    },
}
THUMBNAIL_QUALITY: int = 85
THUMBNAIL_TRANSPARENCY_EXTENSION: str = 'png'
THUMBNAIL_WIDGET_OPTIONS: dict = {'size': (64, 64)}

# настройки для WYSIWYG-редактора CKEditor в админке
CKEDITOR_UPLOAD_PATH: str = "uploads/"
CKEDITOR_BASEPATH: str = "/static/ckeditor/ckeditor/"
CKEDITOR_FILENAME_GENERATOR: str = 'utils.get_filename'
# конфигуратор ckeditor https://ckeditor.com/latest/samples/toolbarconfigurator/index.html#basic
CKEDITOR_CONFIGS: dict = {
    'default': {
        'toolbar_mini': [
            {'name': 'document', 'items': ['Source', '-', ]},
            {'name': 'basicstyles', 'items': ['Bold', 'Italic', 'Underline', 'NumberedList', 'BulletedList',
                                              'Format', '-', 'RemoveFormat']},
            {'name': 'my_custom_tools', 'items': ['Preview', 'Maximize']},
        ],
        'toolbar': 'mini',  # put selected toolbar config here
        'height': '110',
        'toolbarCanCollapse': True,
    },
    'fine': {
        'toolbar_fine': [
            {'name': 'document', 'items': ['Source', '-' ]},
            {'name': 'clipboard', 'items': ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo']},
            {'name': 'basicstyles',
             'items': ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat']},
            {'name': 'my_custom_tools', 'items': ['Preview', 'Maximize']},
            '/',
            {'name': 'paragraph',
             'items': ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-',
                       'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', 'Styles', 'Format', 'Iframe']},
            {'name': 'links', 'items': ['Link', 'Unlink', 'Anchor']},
            {'name': 'insert', 'items': ['Image', 'Table', 'HorizontalRule', 'SpecialChar']},
        ],
        'toolbar': 'fine',
        # 'removeButtons': 'Save,NewPage,ExportPdf,Preview,Print,Templates,Find,Replace,SelectAll,Scayt,Form,'
        #                  'Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,Format,'
        #                  'Font,FontSize,Maximize,ShowBlocks,About,Styles,Flash,Smiley,PageBreak,Iframe,BidiLtr,'
        #                  'BidiRtl,Language,JustifyBlock,JustifyRight,JustifyCenter,JustifyLeft,Indent,Outdent,'
        #                  'Strike,TextColor,BGColor,
        'toolbarCanCollapse': True,
        # 'extraPlugins': 'filer',
        # 'editor': [
        #     {'name': 'filebrowserBrowseUrl', 'items': ''},
        #     {'name': 'filebrowserUploadUrl', 'items': ''},
        # ],
    },
}

FILER_SUBJECT_LOCATION_IMAGE_DEBUG = True
FILER_CANONICAL_URL = 'sharing/'


# Статические файлы (CSS, JavaScript, Images)
# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/4.0/howto/static-files/
STATIC_URL = 'static/'
MEDIA_URL = 'media/'
if DEBUG:     # DEBUG: заменяем настройки прода, на настройки девопа
    MEDIA_ROOT = MY_MEDIA_ROOT_DEV
    # STATIC_ROOT = MY_STATIC_ROOT_DEV1
    STATICFILES_DIRS = [MY_STATIC_ROOT_DEV, ]
else:
    MEDIA_ROOT = MY_MEDIA_ROOT_PROD
    STATIC_ROOT = MY_STATIC_ROOT_PROD
    # STATICFILES_DIRS = [MY_STATIC_ROOT_PROD1, ]

#########################################
# настройки для почтового сервера
EMAIL_HOST = MY_EMAIL_HOST_DEV  # SMTP server
EMAIL_PORT = MY_EMAIL_PORT_DEV  # для SSL/https
EMAIL_HOST_USER = MY_EMAIL_HOST_USER_DEV  # login or ''
EMAIL_HOST_PASSWORD = MY_EMAIL_HOST_PASSWORD_DEV  # password
EMAIL_FROM = MY_EMAIL_FROM_DEV  # мейл, от имени которого отправляются письма

# Database
# https://docs.djangoproject.com/en/4.0/ref/settings/#databases
if DEBUG:     # DEBUG: заменяем настройки прода, на настройки девопа
    if socket.gethostname() == MY_HOST_HOME:      # домашний комп
        DATABASES = {
            'default': {
                'ENGINE': "django.db.backends.mysql",
                'HOST': MY_DATABASE_HOST_DEV1,  # Set to "" for localhost. Not used with sqlite3.
                'PORT': MY_DATABASE_PORT_DEV1,  # Set to "" for default. Not used with sqlite3.
                'NAME': MY_DATABASE_NAME_DEV1,  # Not used with sqlite3.
                'USER': MY_DATABASE_USER_DEV1,  # Not used with sqlite3.
                'PASSWORD': MY_DATABASE_PASSWORD_DEV1,  # Not used with sqlite3.
                # 'OPTIONS': { 'autocommit': True, }
                'OPTIONS': {'charset': 'utf8'},
            }
        }
    elif socket.gethostname() == MY_HOST_WORK:    # офисный комп
        DATABASES = {
            'default': {
                'ENGINE': "django.db.backends.mysql",
                'HOST': MY_DATABASE_HOST_DEV2,  # Set to "" for localhost. Not used with sqlite3.
                'PORT': MY_DATABASE_PORT_DEV2,  # Set to "" for default. Not used with sqlite3.
                'NAME': MY_DATABASE_NAME_DEV2,  # Not used with sqlite3.
                'USER': MY_DATABASE_USER_DEV2,  # Not used with sqlite3.
                'PASSWORD': MY_DATABASE_PASSWORD_DEV2,  # Not used with sqlite3.
                # 'OPTIONS': { 'autocommit': True, }
                # 'OPTIONS': {'charset': 'utf8mb4'},
                'OPTIONS': {'charset': 'utf8'},
            }
        }
else:
    DATABASES = {
        'default': {
            'ENGINE': "django.db.backends.mysql",
            'HOST': MY_DATABASE_HOST_PROD,  # Set to "" for localhost. Not used with sqlite3.
            'PORT': MY_DATABASE_PORT_PROD,  # Set to "" for default. Not used with sqlite3.
            'NAME': MY_DATABASE_NAME_PROD,  # Not used with sqlite3.
            'USER': MY_DATABASE_USER_PROD,  # Not used with sqlite3.
            'PASSWORD': MY_DATABASE_PASSWORD_PROD,  # Not used with sqlite3.
            # 'OPTIONS': { 'autocommit': True, }
            'OPTIONS': {'charset': 'utf8'},
        }
    }

# Тип полей примари-кей
# Default primary key field type
# https://docs.djangoproject.com/en/4.0/ref/settings/#default-auto-field
DEFAULT_AUTO_FIELD = 'django.db.models.AutoField'
# DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
