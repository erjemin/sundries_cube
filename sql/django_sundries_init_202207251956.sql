--
-- Скрипт сгенерирован Devart dbForge Studio 2020 for MySQL, Версия 9.0.567.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 25.07.2022 19:56:07
-- Версия сервера: 10.5.10
-- Версия клиента: 4.1
--

-- 
-- Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Установить режим SQL (SQL mode)
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Установка кодировки, с использованием которой клиент будет посылать запросы на сервер
--
SET NAMES 'utf8';

--
-- Установка базы данных по умолчанию
--
USE django_sundries;

--
-- Удалить таблицу `django_migrations`
--
DROP TABLE IF EXISTS django_migrations;

--
-- Удалить таблицу `django_session`
--
DROP TABLE IF EXISTS django_session;

--
-- Удалить таблицу `filer_thumbnailoption`
--
DROP TABLE IF EXISTS filer_thumbnailoption;

--
-- Удалить таблицу `auth_group_permissions`
--
DROP TABLE IF EXISTS auth_group_permissions;

--
-- Удалить таблицу `auth_user_groups`
--
DROP TABLE IF EXISTS auth_user_groups;

--
-- Удалить таблицу `filer_folderpermission`
--
DROP TABLE IF EXISTS filer_folderpermission;

--
-- Удалить таблицу `auth_group`
--
DROP TABLE IF EXISTS auth_group;

--
-- Удалить таблицу `taggit_taggeditem`
--
DROP TABLE IF EXISTS taggit_taggeditem;

--
-- Удалить таблицу `taggit_tag`
--
DROP TABLE IF EXISTS taggit_tag;

--
-- Удалить таблицу `easy_thumbnails_thumbnaildimensions`
--
DROP TABLE IF EXISTS easy_thumbnails_thumbnaildimensions;

--
-- Удалить таблицу `easy_thumbnails_thumbnail`
--
DROP TABLE IF EXISTS easy_thumbnails_thumbnail;

--
-- Удалить таблицу `easy_thumbnails_source`
--
DROP TABLE IF EXISTS easy_thumbnails_source;

--
-- Удалить таблицу `auth_user_user_permissions`
--
DROP TABLE IF EXISTS auth_user_user_permissions;

--
-- Удалить таблицу `auth_permission`
--
DROP TABLE IF EXISTS auth_permission;

--
-- Удалить таблицу `django_admin_log`
--
DROP TABLE IF EXISTS django_admin_log;

--
-- Удалить таблицу `filer_clipboarditem`
--
DROP TABLE IF EXISTS filer_clipboarditem;

--
-- Удалить таблицу `filer_image`
--
DROP TABLE IF EXISTS filer_image;

--
-- Удалить таблицу `web_tbcontentitem_kImages`
--
DROP TABLE IF EXISTS web_tbcontentitem_kImages;

--
-- Удалить таблицу `web_tbimage`
--
DROP TABLE IF EXISTS web_tbimage;

--
-- Удалить таблицу `filer_file`
--
DROP TABLE IF EXISTS filer_file;

--
-- Удалить таблицу `django_content_type`
--
DROP TABLE IF EXISTS django_content_type;

--
-- Удалить таблицу `filer_clipboard`
--
DROP TABLE IF EXISTS filer_clipboard;

--
-- Удалить таблицу `filer_folder`
--
DROP TABLE IF EXISTS filer_folder;

--
-- Удалить таблицу `web_tbcontentitem`
--
DROP TABLE IF EXISTS web_tbcontentitem;

--
-- Удалить таблицу `auth_user`
--
DROP TABLE IF EXISTS auth_user;

--
-- Установка базы данных по умолчанию
--
USE django_sundries;

--
-- Создать таблицу `auth_user`
--
CREATE TABLE auth_user (
  id int(11) NOT NULL AUTO_INCREMENT,
  password varchar(128) NOT NULL,
  last_login datetime(6) DEFAULT NULL,
  is_superuser tinyint(1) NOT NULL,
  username varchar(150) NOT NULL,
  first_name varchar(150) NOT NULL,
  last_name varchar(150) NOT NULL,
  email varchar(254) NOT NULL,
  is_staff tinyint(1) NOT NULL,
  is_active tinyint(1) NOT NULL,
  date_joined datetime(6) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 2,
AVG_ROW_LENGTH = 16384,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `username` для объекта типа таблица `auth_user`
--
ALTER TABLE auth_user
ADD UNIQUE INDEX username (username);

--
-- Создать таблицу `web_tbcontentitem`
--
CREATE TABLE web_tbcontentitem (
  id int(11) NOT NULL AUTO_INCREMENT,
  bContentPublish tinyint(1) NOT NULL,
  szContentTitle varchar(255) NOT NULL,
  szContentText longtext NOT NULL,
  szContentSlug varchar(255) NOT NULL,
  bContentTypograf tinyint(1) NOT NULL,
  dtContentCreate datetime(6) NOT NULL,
  dtContentTimeStamp datetime(6) NOT NULL,
  kContentItemEdited_id int(11) DEFAULT NULL,
  kUser_id int(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `szContentSlug` для объекта типа таблица `web_tbcontentitem`
--
ALTER TABLE web_tbcontentitem
ADD UNIQUE INDEX szContentSlug (szContentSlug);

--
-- Создать внешний ключ
--
ALTER TABLE web_tbcontentitem
ADD CONSTRAINT web_tbcontentitem_kContentItemEdited_i_64317229_fk_web_tbcon FOREIGN KEY (kContentItemEdited_id)
REFERENCES web_tbcontentitem (id);

--
-- Создать внешний ключ
--
ALTER TABLE web_tbcontentitem
ADD CONSTRAINT web_tbcontentitem_kUser_id_9beb7a47_fk_auth_user_id FOREIGN KEY (kUser_id)
REFERENCES auth_user (id);

--
-- Создать таблицу `filer_folder`
--
CREATE TABLE filer_folder (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  uploaded_at datetime(6) NOT NULL,
  created_at datetime(6) NOT NULL,
  modified_at datetime(6) NOT NULL,
  lft int(10) UNSIGNED NOT NULL CHECK (`lft` >= 0),
  rght int(10) UNSIGNED NOT NULL CHECK (`rght` >= 0),
  tree_id int(10) UNSIGNED NOT NULL CHECK (`tree_id` >= 0),
  level int(10) UNSIGNED NOT NULL CHECK (`level` >= 0),
  owner_id int(11) DEFAULT NULL,
  parent_id int(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `filer_folder_parent_id_name_bc773258_uniq` для объекта типа таблица `filer_folder`
--
ALTER TABLE filer_folder
ADD UNIQUE INDEX filer_folder_parent_id_name_bc773258_uniq (parent_id, name);

--
-- Создать индекс `filer_folder_tree_id_b016223c` для объекта типа таблица `filer_folder`
--
ALTER TABLE filer_folder
ADD INDEX filer_folder_tree_id_b016223c (tree_id);

--
-- Создать индекс `filer_folder_tree_id_lft_088ce52b_idx` для объекта типа таблица `filer_folder`
--
ALTER TABLE filer_folder
ADD INDEX filer_folder_tree_id_lft_088ce52b_idx (tree_id, lft);

--
-- Создать внешний ключ
--
ALTER TABLE filer_folder
ADD CONSTRAINT filer_folder_owner_id_be530fb4_fk_auth_user_id FOREIGN KEY (owner_id)
REFERENCES auth_user (id);

--
-- Создать внешний ключ
--
ALTER TABLE filer_folder
ADD CONSTRAINT filer_folder_parent_id_308aecda_fk_filer_folder_id FOREIGN KEY (parent_id)
REFERENCES filer_folder (id);

--
-- Создать таблицу `filer_clipboard`
--
CREATE TABLE filer_clipboard (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 2,
AVG_ROW_LENGTH = 16384,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать внешний ключ
--
ALTER TABLE filer_clipboard
ADD CONSTRAINT filer_clipboard_user_id_b52ff0bc_fk_auth_user_id FOREIGN KEY (user_id)
REFERENCES auth_user (id);

--
-- Создать таблицу `django_content_type`
--
CREATE TABLE django_content_type (
  id int(11) NOT NULL AUTO_INCREMENT,
  app_label varchar(100) NOT NULL,
  model varchar(100) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 23,
AVG_ROW_LENGTH = 1489,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `django_content_type_app_label_model_76bd3d3b_uniq` для объекта типа таблица `django_content_type`
--
ALTER TABLE django_content_type
ADD UNIQUE INDEX django_content_type_app_label_model_76bd3d3b_uniq (app_label, model);

--
-- Создать таблицу `filer_file`
--
CREATE TABLE filer_file (
  id int(11) NOT NULL AUTO_INCREMENT,
  file varchar(255) DEFAULT NULL,
  _file_size bigint(20) DEFAULT NULL,
  sha1 varchar(40) NOT NULL,
  has_all_mandatory_data tinyint(1) NOT NULL,
  original_filename varchar(255) DEFAULT NULL,
  name varchar(255) NOT NULL,
  description longtext DEFAULT NULL,
  uploaded_at datetime(6) NOT NULL,
  modified_at datetime(6) NOT NULL,
  is_public tinyint(1) NOT NULL,
  folder_id int(11) DEFAULT NULL,
  owner_id int(11) DEFAULT NULL,
  polymorphic_ctype_id int(11) DEFAULT NULL,
  mime_type varchar(255) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать внешний ключ
--
ALTER TABLE filer_file
ADD CONSTRAINT filer_file_folder_id_af803bbb_fk_filer_folder_id FOREIGN KEY (folder_id)
REFERENCES filer_folder (id);

--
-- Создать внешний ключ
--
ALTER TABLE filer_file
ADD CONSTRAINT filer_file_owner_id_b9e32671_fk_auth_user_id FOREIGN KEY (owner_id)
REFERENCES auth_user (id);

--
-- Создать внешний ключ
--
ALTER TABLE filer_file
ADD CONSTRAINT filer_file_polymorphic_ctype_id_f44903c1_fk_django_co FOREIGN KEY (polymorphic_ctype_id)
REFERENCES django_content_type (id);

--
-- Создать таблицу `web_tbimage`
--
CREATE TABLE web_tbimage (
  id int(11) NOT NULL AUTO_INCREMENT,
  bImagePublish tinyint(1) NOT NULL,
  iSort int(11) NOT NULL,
  dtImageTimeStamp datetime(6) NOT NULL,
  flrImage_id int(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `web_tbimage_flrImage_id_ad414bbe` для объекта типа таблица `web_tbimage`
--
ALTER TABLE web_tbimage
ADD INDEX web_tbimage_flrImage_id_ad414bbe (flrImage_id);

--
-- Создать внешний ключ
--
ALTER TABLE web_tbimage
ADD CONSTRAINT web_tbimage_flrImage_id_ad414bbe_fk_filer_file_id FOREIGN KEY (flrImage_id)
REFERENCES filer_file (id);

--
-- Создать таблицу `web_tbcontentitem_kImages`
--
CREATE TABLE web_tbcontentitem_kImages (
  id int(11) NOT NULL AUTO_INCREMENT,
  tbcontentitem_id int(11) NOT NULL,
  tbimage_id int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `web_tbcontentitem_kImage_tbcontentitem_id_tbimage_0d568e1d_uniq` для объекта типа таблица `web_tbcontentitem_kImages`
--
ALTER TABLE web_tbcontentitem_kImages
ADD UNIQUE INDEX web_tbcontentitem_kImage_tbcontentitem_id_tbimage_0d568e1d_uniq (tbcontentitem_id, tbimage_id);

--
-- Создать внешний ключ
--
ALTER TABLE web_tbcontentitem_kImages
ADD CONSTRAINT web_tbcontentitem_kI_tbcontentitem_id_144d2bd4_fk_web_tbcon FOREIGN KEY (tbcontentitem_id)
REFERENCES web_tbcontentitem (id);

--
-- Создать внешний ключ
--
ALTER TABLE web_tbcontentitem_kImages
ADD CONSTRAINT web_tbcontentitem_kImages_tbimage_id_78cbceca_fk_web_tbimage_id FOREIGN KEY (tbimage_id)
REFERENCES web_tbimage (id);

--
-- Создать таблицу `filer_image`
--
CREATE TABLE filer_image (
  file_ptr_id int(11) NOT NULL,
  _height double DEFAULT NULL,
  _width double DEFAULT NULL,
  date_taken datetime(6) DEFAULT NULL,
  default_alt_text varchar(255) DEFAULT NULL,
  default_caption varchar(255) DEFAULT NULL,
  author varchar(255) DEFAULT NULL,
  must_always_publish_author_credit tinyint(1) NOT NULL,
  must_always_publish_copyright tinyint(1) NOT NULL,
  subject_location varchar(64) NOT NULL,
  PRIMARY KEY (file_ptr_id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать внешний ключ
--
ALTER TABLE filer_image
ADD CONSTRAINT filer_image_file_ptr_id_3e21d4f0_fk_filer_file_id FOREIGN KEY (file_ptr_id)
REFERENCES filer_file (id);

--
-- Создать таблицу `filer_clipboarditem`
--
CREATE TABLE filer_clipboarditem (
  id int(11) NOT NULL AUTO_INCREMENT,
  clipboard_id int(11) NOT NULL,
  file_id int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать внешний ключ
--
ALTER TABLE filer_clipboarditem
ADD CONSTRAINT filer_clipboarditem_clipboard_id_7a76518b_fk_filer_clipboard_id FOREIGN KEY (clipboard_id)
REFERENCES filer_clipboard (id);

--
-- Создать внешний ключ
--
ALTER TABLE filer_clipboarditem
ADD CONSTRAINT filer_clipboarditem_file_id_06196f80_fk_filer_file_id FOREIGN KEY (file_id)
REFERENCES filer_file (id);

--
-- Создать таблицу `django_admin_log`
--
CREATE TABLE django_admin_log (
  id int(11) NOT NULL AUTO_INCREMENT,
  action_time datetime(6) NOT NULL,
  object_id longtext DEFAULT NULL,
  object_repr varchar(200) NOT NULL,
  action_flag smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  change_message longtext NOT NULL,
  content_type_id int(11) DEFAULT NULL,
  user_id int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать внешний ключ
--
ALTER TABLE django_admin_log
ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id)
REFERENCES django_content_type (id);

--
-- Создать внешний ключ
--
ALTER TABLE django_admin_log
ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id)
REFERENCES auth_user (id);

--
-- Создать таблицу `auth_permission`
--
CREATE TABLE auth_permission (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  content_type_id int(11) NOT NULL,
  codename varchar(100) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 90,
AVG_ROW_LENGTH = 184,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `auth_permission_content_type_id_codename_01ab375a_uniq` для объекта типа таблица `auth_permission`
--
ALTER TABLE auth_permission
ADD UNIQUE INDEX auth_permission_content_type_id_codename_01ab375a_uniq (content_type_id, codename);

--
-- Создать внешний ключ
--
ALTER TABLE auth_permission
ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id)
REFERENCES django_content_type (id);

--
-- Создать таблицу `auth_user_user_permissions`
--
CREATE TABLE auth_user_user_permissions (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  permission_id int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` для объекта типа таблица `auth_user_user_permissions`
--
ALTER TABLE auth_user_user_permissions
ADD UNIQUE INDEX auth_user_user_permissions_user_id_permission_id_14a6b632_uniq (user_id, permission_id);

--
-- Создать внешний ключ
--
ALTER TABLE auth_user_user_permissions
ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id)
REFERENCES auth_permission (id);

--
-- Создать внешний ключ
--
ALTER TABLE auth_user_user_permissions
ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id)
REFERENCES auth_user (id);

--
-- Создать таблицу `easy_thumbnails_source`
--
CREATE TABLE easy_thumbnails_source (
  id int(11) NOT NULL AUTO_INCREMENT,
  storage_hash varchar(40) NOT NULL,
  name varchar(255) NOT NULL,
  modified datetime(6) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `easy_thumbnails_source_name_5fe0edc6` для объекта типа таблица `easy_thumbnails_source`
--
ALTER TABLE easy_thumbnails_source
ADD INDEX easy_thumbnails_source_name_5fe0edc6 (name);

--
-- Создать индекс `easy_thumbnails_source_storage_hash_946cbcc9` для объекта типа таблица `easy_thumbnails_source`
--
ALTER TABLE easy_thumbnails_source
ADD INDEX easy_thumbnails_source_storage_hash_946cbcc9 (storage_hash);

--
-- Создать индекс `easy_thumbnails_source_storage_hash_name_481ce32d_uniq` для объекта типа таблица `easy_thumbnails_source`
--
ALTER TABLE easy_thumbnails_source
ADD UNIQUE INDEX easy_thumbnails_source_storage_hash_name_481ce32d_uniq (storage_hash, name);

--
-- Создать таблицу `easy_thumbnails_thumbnail`
--
CREATE TABLE easy_thumbnails_thumbnail (
  id int(11) NOT NULL AUTO_INCREMENT,
  storage_hash varchar(40) NOT NULL,
  name varchar(255) NOT NULL,
  modified datetime(6) NOT NULL,
  source_id int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `easy_thumbnails_thumbnai_storage_hash_name_source_fb375270_uniq` для объекта типа таблица `easy_thumbnails_thumbnail`
--
ALTER TABLE easy_thumbnails_thumbnail
ADD UNIQUE INDEX easy_thumbnails_thumbnai_storage_hash_name_source_fb375270_uniq (storage_hash, name, source_id);

--
-- Создать индекс `easy_thumbnails_thumbnail_name_b5882c31` для объекта типа таблица `easy_thumbnails_thumbnail`
--
ALTER TABLE easy_thumbnails_thumbnail
ADD INDEX easy_thumbnails_thumbnail_name_b5882c31 (name);

--
-- Создать индекс `easy_thumbnails_thumbnail_storage_hash_f1435f49` для объекта типа таблица `easy_thumbnails_thumbnail`
--
ALTER TABLE easy_thumbnails_thumbnail
ADD INDEX easy_thumbnails_thumbnail_storage_hash_f1435f49 (storage_hash);

--
-- Создать внешний ключ
--
ALTER TABLE easy_thumbnails_thumbnail
ADD CONSTRAINT easy_thumbnails_thum_source_id_5b57bc77_fk_easy_thum FOREIGN KEY (source_id)
REFERENCES easy_thumbnails_source (id);

--
-- Создать таблицу `easy_thumbnails_thumbnaildimensions`
--
CREATE TABLE easy_thumbnails_thumbnaildimensions (
  id int(11) NOT NULL AUTO_INCREMENT,
  thumbnail_id int(11) NOT NULL,
  width int(10) UNSIGNED DEFAULT NULL CHECK (`width` >= 0),
  height int(10) UNSIGNED DEFAULT NULL CHECK (`height` >= 0),
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `thumbnail_id` для объекта типа таблица `easy_thumbnails_thumbnaildimensions`
--
ALTER TABLE easy_thumbnails_thumbnaildimensions
ADD UNIQUE INDEX thumbnail_id (thumbnail_id);

--
-- Создать внешний ключ
--
ALTER TABLE easy_thumbnails_thumbnaildimensions
ADD CONSTRAINT easy_thumbnails_thum_thumbnail_id_c3a0c549_fk_easy_thum FOREIGN KEY (thumbnail_id)
REFERENCES easy_thumbnails_thumbnail (id);

--
-- Создать таблицу `taggit_tag`
--
CREATE TABLE taggit_tag (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  slug varchar(100) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `name` для объекта типа таблица `taggit_tag`
--
ALTER TABLE taggit_tag
ADD UNIQUE INDEX name (name);

--
-- Создать индекс `slug` для объекта типа таблица `taggit_tag`
--
ALTER TABLE taggit_tag
ADD UNIQUE INDEX slug (slug);

--
-- Создать таблицу `taggit_taggeditem`
--
CREATE TABLE taggit_taggeditem (
  id int(11) NOT NULL AUTO_INCREMENT,
  object_id int(11) NOT NULL,
  content_type_id int(11) NOT NULL,
  tag_id int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `taggit_taggeditem_content_type_id_object_id_196cc965_idx` для объекта типа таблица `taggit_taggeditem`
--
ALTER TABLE taggit_taggeditem
ADD INDEX taggit_taggeditem_content_type_id_object_id_196cc965_idx (content_type_id, object_id);

--
-- Создать индекс `taggit_taggeditem_content_type_id_object_id_tag_id_4bb97a8e_uniq` для объекта типа таблица `taggit_taggeditem`
--
ALTER TABLE taggit_taggeditem
ADD UNIQUE INDEX taggit_taggeditem_content_type_id_object_id_tag_id_4bb97a8e_uniq (content_type_id, object_id, tag_id);

--
-- Создать индекс `taggit_taggeditem_object_id_e2d7d1df` для объекта типа таблица `taggit_taggeditem`
--
ALTER TABLE taggit_taggeditem
ADD INDEX taggit_taggeditem_object_id_e2d7d1df (object_id);

--
-- Создать внешний ключ
--
ALTER TABLE taggit_taggeditem
ADD CONSTRAINT taggit_taggeditem_content_type_id_9957a03c_fk_django_co FOREIGN KEY (content_type_id)
REFERENCES django_content_type (id);

--
-- Создать внешний ключ
--
ALTER TABLE taggit_taggeditem
ADD CONSTRAINT taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id FOREIGN KEY (tag_id)
REFERENCES taggit_tag (id);

--
-- Создать таблицу `auth_group`
--
CREATE TABLE auth_group (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(150) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `name` для объекта типа таблица `auth_group`
--
ALTER TABLE auth_group
ADD UNIQUE INDEX name (name);

--
-- Создать таблицу `filer_folderpermission`
--
CREATE TABLE filer_folderpermission (
  id int(11) NOT NULL AUTO_INCREMENT,
  type smallint(6) NOT NULL,
  everybody tinyint(1) NOT NULL,
  can_edit smallint(6) DEFAULT NULL,
  can_read smallint(6) DEFAULT NULL,
  can_add_children smallint(6) DEFAULT NULL,
  folder_id int(11) DEFAULT NULL,
  group_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать внешний ключ
--
ALTER TABLE filer_folderpermission
ADD CONSTRAINT filer_folderpermission_folder_id_5d02f1da_fk_filer_folder_id FOREIGN KEY (folder_id)
REFERENCES filer_folder (id);

--
-- Создать внешний ключ
--
ALTER TABLE filer_folderpermission
ADD CONSTRAINT filer_folderpermission_group_id_8901bafa_fk_auth_group_id FOREIGN KEY (group_id)
REFERENCES auth_group (id);

--
-- Создать внешний ключ
--
ALTER TABLE filer_folderpermission
ADD CONSTRAINT filer_folderpermission_user_id_7673d4b6_fk_auth_user_id FOREIGN KEY (user_id)
REFERENCES auth_user (id);

--
-- Создать таблицу `auth_user_groups`
--
CREATE TABLE auth_user_groups (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  group_id int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `auth_user_groups_user_id_group_id_94350c0c_uniq` для объекта типа таблица `auth_user_groups`
--
ALTER TABLE auth_user_groups
ADD UNIQUE INDEX auth_user_groups_user_id_group_id_94350c0c_uniq (user_id, group_id);

--
-- Создать внешний ключ
--
ALTER TABLE auth_user_groups
ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id)
REFERENCES auth_group (id);

--
-- Создать внешний ключ
--
ALTER TABLE auth_user_groups
ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id)
REFERENCES auth_user (id);

--
-- Создать таблицу `auth_group_permissions`
--
CREATE TABLE auth_group_permissions (
  id int(11) NOT NULL AUTO_INCREMENT,
  group_id int(11) NOT NULL,
  permission_id int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` для объекта типа таблица `auth_group_permissions`
--
ALTER TABLE auth_group_permissions
ADD UNIQUE INDEX auth_group_permissions_group_id_permission_id_0cd325b0_uniq (group_id, permission_id);

--
-- Создать внешний ключ
--
ALTER TABLE auth_group_permissions
ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id)
REFERENCES auth_permission (id);

--
-- Создать внешний ключ
--
ALTER TABLE auth_group_permissions
ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id)
REFERENCES auth_group (id);

--
-- Создать таблицу `filer_thumbnailoption`
--
CREATE TABLE filer_thumbnailoption (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  width int(11) NOT NULL,
  height int(11) NOT NULL,
  crop tinyint(1) NOT NULL,
  upscale tinyint(1) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать таблицу `django_session`
--
CREATE TABLE django_session (
  session_key varchar(40) NOT NULL,
  session_data longtext NOT NULL,
  expire_date datetime(6) NOT NULL,
  PRIMARY KEY (session_key)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 16384,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

--
-- Создать индекс `django_session_expire_date_a5c62663` для объекта типа таблица `django_session`
--
ALTER TABLE django_session
ADD INDEX django_session_expire_date_a5c62663 (expire_date);

--
-- Создать таблицу `django_migrations`
--
CREATE TABLE django_migrations (
  id int(11) NOT NULL AUTO_INCREMENT,
  app varchar(255) NOT NULL,
  name varchar(255) NOT NULL,
  applied datetime(6) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 42,
AVG_ROW_LENGTH = 399,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci;

-- 
-- Вывод данных для таблицы auth_user
--
INSERT INTO auth_user VALUES
(1, 'pbkdf2_sha256$320000$udVohP1kvoTSOvlcJkKRK9$yxD429iiQx2mo+XBMgSZMFcUMizEcMEQpFO0/1rOkuU=', '2022-07-25 16:55:08.104485', 1, 'e-serg', '', '', 'erjemin@gmail.com', 1, 1, '2022-07-25 16:55:05.092468');

-- 
-- Вывод данных для таблицы filer_folder
--
-- Таблица django_sundries.filer_folder не содержит данных

-- 
-- Вывод данных для таблицы django_content_type
--
INSERT INTO django_content_type VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'easy_thumbnails', 'source'),
(8, 'easy_thumbnails', 'thumbnail'),
(9, 'easy_thumbnails', 'thumbnaildimensions'),
(10, 'filer', 'clipboard'),
(11, 'filer', 'clipboarditem'),
(12, 'filer', 'file'),
(13, 'filer', 'folder'),
(14, 'filer', 'folderpermission'),
(15, 'filer', 'image'),
(16, 'filer', 'thumbnailoption'),
(6, 'sessions', 'session'),
(17, 'taggit', 'tag'),
(18, 'taggit', 'taggeditem'),
(19, 'web', 'rutag'),
(20, 'web', 'rutaggeditem'),
(22, 'web', 'tbcontentitem'),
(21, 'web', 'tbimage');

-- 
-- Вывод данных для таблицы filer_file
--
-- Таблица django_sundries.filer_file не содержит данных

-- 
-- Вывод данных для таблицы easy_thumbnails_source
--
-- Таблица django_sundries.easy_thumbnails_source не содержит данных

-- 
-- Вывод данных для таблицы web_tbimage
--
-- Таблица django_sundries.web_tbimage не содержит данных

-- 
-- Вывод данных для таблицы web_tbcontentitem
--
-- Таблица django_sundries.web_tbcontentitem не содержит данных

-- 
-- Вывод данных для таблицы taggit_tag
--
-- Таблица django_sundries.taggit_tag не содержит данных

-- 
-- Вывод данных для таблицы filer_clipboard
--
INSERT INTO filer_clipboard VALUES
(1, 1);

-- 
-- Вывод данных для таблицы easy_thumbnails_thumbnail
--
-- Таблица django_sundries.easy_thumbnails_thumbnail не содержит данных

-- 
-- Вывод данных для таблицы auth_permission
--
INSERT INTO auth_permission VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add source', 7, 'add_source'),
(26, 'Can change source', 7, 'change_source'),
(27, 'Can delete source', 7, 'delete_source'),
(28, 'Can view source', 7, 'view_source'),
(29, 'Can add thumbnail', 8, 'add_thumbnail'),
(30, 'Can change thumbnail', 8, 'change_thumbnail'),
(31, 'Can delete thumbnail', 8, 'delete_thumbnail'),
(32, 'Can view thumbnail', 8, 'view_thumbnail'),
(33, 'Can add thumbnail dimensions', 9, 'add_thumbnaildimensions'),
(34, 'Can change thumbnail dimensions', 9, 'change_thumbnaildimensions'),
(35, 'Can delete thumbnail dimensions', 9, 'delete_thumbnaildimensions'),
(36, 'Can view thumbnail dimensions', 9, 'view_thumbnaildimensions'),
(37, 'Can add clipboard', 10, 'add_clipboard'),
(38, 'Can change clipboard', 10, 'change_clipboard'),
(39, 'Can delete clipboard', 10, 'delete_clipboard'),
(40, 'Can view clipboard', 10, 'view_clipboard'),
(41, 'Can add clipboard item', 11, 'add_clipboarditem'),
(42, 'Can change clipboard item', 11, 'change_clipboarditem'),
(43, 'Can delete clipboard item', 11, 'delete_clipboarditem'),
(44, 'Can view clipboard item', 11, 'view_clipboarditem'),
(45, 'Can add file', 12, 'add_file'),
(46, 'Can change file', 12, 'change_file'),
(47, 'Can delete file', 12, 'delete_file'),
(48, 'Can view file', 12, 'view_file'),
(49, 'Can add Folder', 13, 'add_folder'),
(50, 'Can change Folder', 13, 'change_folder'),
(51, 'Can delete Folder', 13, 'delete_folder'),
(52, 'Can view Folder', 13, 'view_folder'),
(53, 'Can use directory listing', 13, 'can_use_directory_listing'),
(54, 'Can add folder permission', 14, 'add_folderpermission'),
(55, 'Can change folder permission', 14, 'change_folderpermission'),
(56, 'Can delete folder permission', 14, 'delete_folderpermission'),
(57, 'Can view folder permission', 14, 'view_folderpermission'),
(58, 'Can add image', 15, 'add_image'),
(59, 'Can change image', 15, 'change_image'),
(60, 'Can delete image', 15, 'delete_image'),
(61, 'Can view image', 15, 'view_image'),
(62, 'Can add thumbnail option', 16, 'add_thumbnailoption'),
(63, 'Can change thumbnail option', 16, 'change_thumbnailoption'),
(64, 'Can delete thumbnail option', 16, 'delete_thumbnailoption'),
(65, 'Can view thumbnail option', 16, 'view_thumbnailoption'),
(66, 'Can add tag', 17, 'add_tag'),
(67, 'Can change tag', 17, 'change_tag'),
(68, 'Can delete tag', 17, 'delete_tag'),
(69, 'Can view tag', 17, 'view_tag'),
(70, 'Can add tagged item', 18, 'add_taggeditem'),
(71, 'Can change tagged item', 18, 'change_taggeditem'),
(72, 'Can delete tagged item', 18, 'delete_taggeditem'),
(73, 'Can view tagged item', 18, 'view_taggeditem'),
(74, 'Can add ru tag', 19, 'add_rutag'),
(75, 'Can change ru tag', 19, 'change_rutag'),
(76, 'Can delete ru tag', 19, 'delete_rutag'),
(77, 'Can view ru tag', 19, 'view_rutag'),
(78, 'Can add ru tagged item', 20, 'add_rutaggeditem'),
(79, 'Can change ru tagged item', 20, 'change_rutaggeditem'),
(80, 'Can delete ru tagged item', 20, 'delete_rutaggeditem'),
(81, 'Can view ru tagged item', 20, 'view_rutaggeditem'),
(82, 'Can add […Изображение]', 21, 'add_tbimage'),
(83, 'Can change […Изображение]', 21, 'change_tbimage'),
(84, 'Can delete […Изображение]', 21, 'delete_tbimage'),
(85, 'Can view […Изображение]', 21, 'view_tbimage'),
(86, 'Can add […Контент]', 22, 'add_tbcontentitem'),
(87, 'Can change […Контент]', 22, 'change_tbcontentitem'),
(88, 'Can delete […Контент]', 22, 'delete_tbcontentitem'),
(89, 'Can view […Контент]', 22, 'view_tbcontentitem');

-- 
-- Вывод данных для таблицы auth_group
--
-- Таблица django_sundries.auth_group не содержит данных

-- 
-- Вывод данных для таблицы web_tbcontentitem_kImages
--
-- Таблица django_sundries.web_tbcontentitem_kImages не содержит данных

-- 
-- Вывод данных для таблицы taggit_taggeditem
--
-- Таблица django_sundries.taggit_taggeditem не содержит данных

-- 
-- Вывод данных для таблицы filer_thumbnailoption
--
-- Таблица django_sundries.filer_thumbnailoption не содержит данных

-- 
-- Вывод данных для таблицы filer_image
--
-- Таблица django_sundries.filer_image не содержит данных

-- 
-- Вывод данных для таблицы filer_folderpermission
--
-- Таблица django_sundries.filer_folderpermission не содержит данных

-- 
-- Вывод данных для таблицы filer_clipboarditem
--
-- Таблица django_sundries.filer_clipboarditem не содержит данных

-- 
-- Вывод данных для таблицы easy_thumbnails_thumbnaildimensions
--
-- Таблица django_sundries.easy_thumbnails_thumbnaildimensions не содержит данных

-- 
-- Вывод данных для таблицы django_session
--
INSERT INTO django_session VALUES
('0ghr5l7bs8uge2fot0r68pu5eufu8v2j', '.eJxVjk0KwyAQhe_iukjGWGO67D5nEGcmNmlFIcZV6d1rIIt29eD9fLy3cL7ui6tl3tzK4iZAXH499PSa0xHw06dHlpTTvq0oj4o80yKnzHO8n90_wOLL0tbKsMJgNbHWQ4DeXkcewfgmhkhZ7JkNAqHpiC0MjB0BBlAaTMdWN2hYY-NFX3YXcuTzcKoxfr6b3UKL:1oG1Mg:2MyL1qeeAzKZl9QxiPHPBkJhVOU8f3uptHSu59wguSI', '2022-08-08 16:55:30.72951');

-- 
-- Вывод данных для таблицы django_migrations
--
INSERT INTO django_migrations VALUES
(1, 'contenttypes', '0001_initial', '2022-07-25 16:53:27.355269'),
(2, 'auth', '0001_initial', '2022-07-25 16:53:27.978531'),
(3, 'admin', '0001_initial', '2022-07-25 16:53:28.133948'),
(4, 'admin', '0002_logentry_remove_auto_add', '2022-07-25 16:53:28.156289'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2022-07-25 16:53:28.177279'),
(6, 'contenttypes', '0002_remove_content_type_name', '2022-07-25 16:53:28.258138'),
(7, 'auth', '0002_alter_permission_name_max_length', '2022-07-25 16:53:28.332252'),
(8, 'auth', '0003_alter_user_email_max_length', '2022-07-25 16:53:28.405982'),
(9, 'auth', '0004_alter_user_username_opts', '2022-07-25 16:53:28.427736'),
(10, 'auth', '0005_alter_user_last_login_null', '2022-07-25 16:53:28.490095'),
(11, 'auth', '0006_require_contenttypes_0002', '2022-07-25 16:53:28.505799'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2022-07-25 16:53:28.528875'),
(13, 'auth', '0008_alter_user_username_max_length', '2022-07-25 16:53:28.561925'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2022-07-25 16:53:28.595558'),
(15, 'auth', '0010_alter_group_name_max_length', '2022-07-25 16:53:28.671752'),
(16, 'auth', '0011_update_proxy_permissions', '2022-07-25 16:53:28.697032'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2022-07-25 16:53:28.730289'),
(18, 'easy_thumbnails', '0001_initial', '2022-07-25 16:53:28.954452'),
(19, 'easy_thumbnails', '0002_thumbnaildimensions', '2022-07-25 16:53:29.056203'),
(20, 'filer', '0001_initial', '2022-07-25 16:53:30.035847'),
(21, 'filer', '0002_auto_20150606_2003', '2022-07-25 16:53:30.069268'),
(22, 'filer', '0003_thumbnailoption', '2022-07-25 16:53:30.117232'),
(23, 'filer', '0004_auto_20160328_1434', '2022-07-25 16:53:30.239226'),
(24, 'filer', '0005_auto_20160623_1425', '2022-07-25 16:53:30.292337'),
(25, 'filer', '0006_auto_20160623_1627', '2022-07-25 16:53:30.424036'),
(26, 'filer', '0007_auto_20161016_1055', '2022-07-25 16:53:30.436625'),
(27, 'filer', '0008_auto_20171117_1313', '2022-07-25 16:53:30.454305'),
(28, 'filer', '0009_auto_20171220_1635', '2022-07-25 16:53:30.526822'),
(29, 'filer', '0010_auto_20180414_2058', '2022-07-25 16:53:30.545631'),
(30, 'filer', '0011_auto_20190418_0137', '2022-07-25 16:53:30.726465'),
(31, 'filer', '0012_file_mime_type', '2022-07-25 16:53:30.77816'),
(32, 'filer', '0013_image_width_height_to_float', '2022-07-25 16:53:30.897032'),
(33, 'filer', '0014_folder_permission_choices', '2022-07-25 16:53:30.929213'),
(34, 'filer', '0015_alter_file_owner_alter_file_polymorphic_ctype_and_more', '2022-07-25 16:53:30.967311'),
(35, 'sessions', '0001_initial', '2022-07-25 16:53:31.037234'),
(36, 'taggit', '0001_initial', '2022-07-25 16:53:31.248564'),
(37, 'taggit', '0002_auto_20150616_2121', '2022-07-25 16:53:31.285734'),
(38, 'taggit', '0003_taggeditem_add_unique_index', '2022-07-25 16:53:31.317329'),
(39, 'taggit', '0004_alter_taggeditem_content_type_alter_taggeditem_tag', '2022-07-25 16:53:31.351789'),
(40, 'taggit', '0005_auto_20220424_2025', '2022-07-25 16:53:31.366011'),
(41, 'web', '0001_initial', '2022-07-25 16:53:31.805342');

-- 
-- Вывод данных для таблицы django_admin_log
--
-- Таблица django_sundries.django_admin_log не содержит данных

-- 
-- Вывод данных для таблицы auth_user_user_permissions
--
-- Таблица django_sundries.auth_user_user_permissions не содержит данных

-- 
-- Вывод данных для таблицы auth_user_groups
--
-- Таблица django_sundries.auth_user_groups не содержит данных

-- 
-- Вывод данных для таблицы auth_group_permissions
--
-- Таблица django_sundries.auth_group_permissions не содержит данных

-- 
-- Восстановить предыдущий режим SQL (SQL mode)
--
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;