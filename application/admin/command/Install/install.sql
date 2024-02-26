-- ----------------------------
-- Table structure for oc_action_limit
-- ----------------------------
DROP TABLE IF EXISTS `oc_user_action_limit`;
CREATE TABLE `oc_user_action_limit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '标题',
  `rule_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户权限id',
  `frequency` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '频率',
  `time_number` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '时间数量',
  `time_unit` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '时间单位类型 1-秒 2-分钟 3-小时 4-天 5-周 6-月 7-年',
  `punish_type` text NOT NULL DEFAULT '' COMMENT '处罚类型 1-警告并禁止 2-强制退出登录 3-封停账户 4-封IP',
  `if_message` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否发送消息 0-否 1-是',
  `message_content` text NOT NULL COMMENT '消息提示内容',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 -1-删除 0-禁用 1-启用',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `rule_id` (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行为限制表';

-- ----------------------------
-- Records of oc_action_limit
-- ----------------------------

-- ----------------------------
-- Table structure for oc_action_log
-- ----------------------------
DROP TABLE IF EXISTS `oc_user_action_log`;
CREATE TABLE `oc_user_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `action_ip` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `is_score` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否添加积分',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `action_ip` (`action_ip`),
  KEY `action_id` (`action_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='行为日志表';

-- ----------------------------
-- Records of oc_action_log
-- ----------------------------

-- ----------------------------
-- Table structure for oc_admin
-- ----------------------------
DROP TABLE IF EXISTS `oc_admin`;
CREATE TABLE `oc_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` varchar(60) NOT NULL DEFAULT '' COMMENT '管理员权限组id，多个用,分隔',
  `current_group` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '当前分组',
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` char(11) NOT NULL DEFAULT '' COMMENT '用户手机',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of oc_admin
-- ----------------------------
INSERT INTO `oc_admin` VALUES ('1', '1', '1', 'admin', '347940aacdbd9d502325150ae5d07d96', 'admin@admin.com', '12345678910', '0', '0', '0', '1');

-- ----------------------------
-- Table structure for oc_admin_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `oc_admin_auth_group`;
CREATE TABLE `oc_admin_auth_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父组别',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '权限组所属模块',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '组类型',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '权限组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '权限组状态：为1正常，为0禁用,-1为删除',
  `rules` text NOT NULL COMMENT '权限组拥有的规则id，多个规则 , 隔开',
  `end_time` int(11) unsigned NOT NULL DEFAULT '2000000000' COMMENT '有效期',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='管理员权限组表';

-- ----------------------------
-- Records of oc_admin_auth_group
-- ----------------------------
INSERT INTO `oc_admin_auth_group` VALUES ('1', '0', 'admin', '1', '超级管理员', '至高无上', '1', '*', '2000000000', '0', '0');
INSERT INTO `oc_admin_auth_group` VALUES ('2', '1', 'admin', '1', '管理员', '一人之下，万人之上', '1', '', '2000000000', '0', '0');

-- ----------------------------
-- Table structure for oc_admin_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `oc_admin_auth_rule`;
CREATE TABLE `oc_admin_auth_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文标题',
  `icon` varchar(50) NOT NULL DEFAULT '' COMMENT '图标',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  `is_menu` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否菜单 0-不是 1-是',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示 0-不是 1-是',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `sort` int(11) unsigned NOT NULL DEFAULT '100' COMMENT '排序，默认升序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `pid` (`pid`),
  KEY `remark` (`remark`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='权限表';

-- ----------------------------
-- Records of oc_admin_auth_rule
-- ----------------------------
INSERT INTO `oc_admin_auth_rule` VALUES ('1', '0', 'admin', 'admin/admin', '管理员管理', 'layui-icon-username', '', '1', '', '1', '1', '0', '0', '100');
INSERT INTO `oc_admin_auth_rule` VALUES ('2', '1', 'admin', 'admin/admin/adminList', '管理员列表', '', '', '1', '', '1', '1', '0', '0', '101');
INSERT INTO `oc_admin_auth_rule` VALUES ('3', '2', 'admin', 'admin/admin/deladmin', '删除管理员', '', '', '1', '', '0', '0', '0', '0', '102');
INSERT INTO `oc_admin_auth_rule` VALUES ('4', '2', 'admin', 'admin/admin/adminform', '管理员表单', '', '', '1', '', '0', '0', '0', '0', '103');
INSERT INTO `oc_admin_auth_rule` VALUES ('5', '1', 'admin', 'admin/admin/adminauthlist', '管理权限', '', '', '1', '', '1', '1', '0', '0', '111');
INSERT INTO `oc_admin_auth_rule` VALUES ('6', '5', 'admin', 'admin/admin/deladminauth', '删除管理权限', '', '', '1', '', '0', '0', '0', '0', '112');
INSERT INTO `oc_admin_auth_rule` VALUES ('7', '5', 'admin', 'admin/admin/adminauthform', '管理权限表单', '', '', '1', '', '0', '0', '0', '0', '113');
INSERT INTO `oc_admin_auth_rule` VALUES ('8', '1', 'admin', 'admin/admin/adminauthgrouplist', '管理分组', '', '', '1', '', '1', '1', '0', '0', '121');
INSERT INTO `oc_admin_auth_rule` VALUES ('9', '8', 'admin', 'admin/admin/adminauthgroupform', '管理权限分组表单', '', '', '1', '', '0', '0', '0', '0', '122');
INSERT INTO `oc_admin_auth_rule` VALUES ('10', '8', 'admin', 'admin/admin/deladminauthgroup', '删除管理权限分组', '', '', '1', '', '0', '0', '0', '0', '123');
INSERT INTO `oc_admin_auth_rule` VALUES ('11', '1', 'admin', 'admin/admin/adminlog', '管理日志', '', '', '1', '', '1', '1', '0', '0', '130');
INSERT INTO `oc_admin_auth_rule` VALUES (12, 0, 'admin', 'admin/index/index', '主页', 'layui-icon-home', '', 1, '', 1, 1, 0, 0, 10);
INSERT INTO `oc_admin_auth_rule` VALUES (13, 12, 'admin', 'admin/index/console', '控制台', '', '', 1, '', 1, 1, 0, 0, 11);
INSERT INTO `oc_admin_auth_rule` VALUES ('14', '12', 'admin', 'admin/index/homepage', '仪表盘', '', '', '1', '', '0', '0', '0', '0', '12');
INSERT INTO `oc_admin_auth_rule` VALUES ('15', '0', 'admin', 'admin/user', '用户管理', '', '', '1', '', '1', '1', '0', '0', '140');
INSERT INTO `oc_admin_auth_rule` VALUES ('16', '15', 'admin', 'admin/user/registerconfig', '注册配置', '', '', '1', '', '1', '1', '0', '0', '141');
INSERT INTO `oc_admin_auth_rule` VALUES ('17', '15', 'admin', 'admin/user/userlist', '用户管理', '', '', '1', '', '1', '1', '0', '0', '142');
INSERT INTO `oc_admin_auth_rule` VALUES ('18', '15', 'admin', 'admin/user/userrole', '用户角色', '', '', '1', '', '1', '1', '0', '0', '143');
INSERT INTO `oc_admin_auth_rule` VALUES ('19', '15', 'admin', 'admin/user/userauth', '用户权限', '', '', '1', '', '1', '1', '0', '0', '144');
INSERT INTO `oc_admin_auth_rule` VALUES ('20', '15', 'admin', 'admin/user/userlog', '用户日志', '', '', '1', '', '1', '1', '0', '0', '145');
INSERT INTO `oc_admin_auth_rule` VALUES ('21', '0', 'admin', 'admin/operation', '运营', 'layui-icon-fire', '', '1', '', '1', '1', '0', '0', '160');
INSERT INTO `oc_admin_auth_rule` VALUES ('22', '21', 'admin', 'admin/adv/pos', '广告位置', '', '', '1', '', '1', '1', '0', '0', '161');
INSERT INTO `oc_admin_auth_rule` VALUES ('23', '21', 'admin', 'admin/score/typelist', '积分管理', '', '', '1', '', '1', '1', '0', '0', '162');
INSERT INTO `oc_admin_auth_rule` VALUES ('24', '0', 'admin', 'admin/safe', '安全', 'layui-icon-vercode', '', '1', '', '1', '1', '0', '0', '170');
INSERT INTO `oc_admin_auth_rule` VALUES ('25', '24', 'admin', 'admin/action/actionlimit', '行为限制', '', '', '1', '', '1', '1', '0', '0', '171');
INSERT INTO `oc_admin_auth_rule` VALUES ('26', '24', 'admin', 'admin/action/actionlimitform', '行为限制表单', '', '', '1', '', '0', '0', '0', '0', '172');
INSERT INTO `oc_admin_auth_rule` VALUES ('27', '24', 'admin', 'admin/action/delactionlimit', '删除行为限制', '', '', '1', '', '0', '0', '0', '0', '173');

-- ----------------------------
-- Table structure for oc_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `oc_admin_log`;
CREATE TABLE `oc_admin_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '管理员名字',
  `module` varchar(30) NOT NULL DEFAULT '' COMMENT '模块名',
  `action` varchar(255) NOT NULL DEFAULT '' COMMENT '方法名',
  `param` text NOT NULL COMMENT '参数 json',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'IP',
  `user_agent` varchar(255) NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `username` (`username`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='管理员日志表';

-- ----------------------------
-- Records of oc_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for oc_adv
-- ----------------------------
DROP TABLE IF EXISTS `oc_common_adv`;
CREATE TABLE `oc_common_adv` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '广告名称',
  `pos_id` int(11) NOT NULL COMMENT '广告位置',
  `data` text NOT NULL COMMENT '图片地址',
  `click_count` int(11) NOT NULL COMMENT '点击量',
  `url` varchar(500) NOT NULL COMMENT '链接地址',
  `sort` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：正常）',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `start_time` int(11) DEFAULT NULL,
  `end_time` int(11) unsigned DEFAULT '0' COMMENT '结束时间',
  `target` varchar(20) DEFAULT '_blank',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告表';

-- ----------------------------
-- Records of oc_adv
-- ----------------------------

-- ----------------------------
-- Table structure for oc_adv_pos
-- ----------------------------
DROP TABLE IF EXISTS `oc_common_adv_pos`;
CREATE TABLE `oc_common_adv_pos` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL,
  `title` char(80) NOT NULL DEFAULT '' COMMENT '广告位置名称',
  `path` varchar(100) NOT NULL COMMENT '所在路径 模块/控制器/方法',
  `type` int(11) unsigned NOT NULL DEFAULT '1' COMMENT '广告位类型 \r\n1.单图\r\n2.多图\r\n3.文字链接\r\n4.代码',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：正常）',
  `data` varchar(500) NOT NULL COMMENT '额外的数据',
  `width` char(20) NOT NULL DEFAULT '' COMMENT '广告位置宽度',
  `height` char(20) NOT NULL DEFAULT '' COMMENT '广告位置高度',
  `margin` varchar(50) NOT NULL COMMENT '边缘',
  `padding` varchar(50) NOT NULL COMMENT '留白',
  `theme` varchar(50) NOT NULL DEFAULT 'all' COMMENT '适用主题，默认为all，通用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告位置表';

-- ----------------------------
-- Records of oc_adv_pos
-- ----------------------------

-- ----------------------------
-- Table structure for oc_config
-- ----------------------------
DROP TABLE IF EXISTS `oc_common_config`;
CREATE TABLE `oc_common_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '配置名称',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT '模块名',
  `controller` varchar(64) NOT NULL DEFAULT '' COMMENT '控制器名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(500) NOT NULL COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text NOT NULL COMMENT '配置值',
  `sort` int(11) unsigned NOT NULL DEFAULT '500' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `config_name` (`module`,`controller`,`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='配置表';

-- ----------------------------
-- Records of oc_config
-- ----------------------------
INSERT INTO `oc_common_config` VALUES ('1', 'register_type', 'admin', 'user', '0', '', '0', '', '', '0', '0', '1', 'normal', '0');
INSERT INTO `oc_common_config` VALUES ('2', 'reg_switch', 'admin', 'user', '0', '', '0', '', '', '0', '0', '1', 'email,mobile', '0');
INSERT INTO `oc_common_config` VALUES ('3', 'email_verify_type', 'admin', 'user', '0', '', '0', '', '', '0', '0', '1', '0', '0');
INSERT INTO `oc_common_config` VALUES ('4', 'mobile_verify_type', 'admin', 'user', '0', '', '0', '', '', '0', '0', '1', '0', '0');

-- ----------------------------
-- Table structure for oc_score_log
-- ----------------------------
DROP TABLE IF EXISTS `oc_user_score_log`;
CREATE TABLE `oc_user_score_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `ip` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'IP',
  `score_type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '积分类型 1-积分',
  `value` double NOT NULL DEFAULT '0' COMMENT '积分变动',
  `finally_value` double unsigned NOT NULL DEFAULT '0' COMMENT '变更后积分',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `model` varchar(20) NOT NULL DEFAULT '' COMMENT '模块名',
  `rule_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '权限id',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `rule_id` (`rule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='用户积分变动表';

-- ----------------------------
-- Records of oc_score_log
-- ----------------------------

-- ----------------------------
-- Table structure for oc_user
-- ----------------------------
DROP TABLE IF EXISTS `oc_user`;
CREATE TABLE `oc_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户组ID',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `amount` decimal(10,2) NOT NULL DEFAULT '0' COMMENT '余额',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_agent` varchar(255) NOT NULL DEFAULT '' COMMENT '注册终端',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1为用户名注册，2为邮箱注册，3为手机注册',
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `email` (`email`),
  KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of oc_user
-- ----------------------------


-- ----------------------------
-- Table structure for oc_user_role
-- ----------------------------
DROP TABLE IF EXISTS `oc_user_role`;
CREATE TABLE `oc_user_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(50) DEFAULT '' COMMENT '角色名',
  `title` varchar(25) NOT NULL COMMENT '标题',
  `description` varchar(500) NOT NULL COMMENT '描述',
  `rules` text NOT NULL COMMENT '权限节点',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- ----------------------------
-- Records of oc_user_role
-- ----------------------------
INSERT INTO `oc_user_role` VALUES ('1', '0', '普通用户', '普通用户', '普通用户', '1,2,3', '0', '0', '0', '1');
INSERT INTO `oc_user_role` VALUES ('2', '0', '游客', '游客', '游客', '', '0', '0', '0', '1');

-- ----------------------------
-- Table structure for oc_user_rule
-- ----------------------------
DROP TABLE IF EXISTS `oc_user_rule`;
CREATE TABLE `oc_user_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文标题',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `sort` int(11) unsigned NOT NULL DEFAULT '100' COMMENT '排序，默认升序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `pid` (`pid`),
  KEY `remark` (`remark`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='用户权限表';

-- ----------------------------
-- Records of oc_user_rule
-- ----------------------------
INSERT INTO `oc_user_rule` VALUES ('1', '0', 'weibo', 'weibo/index/index', '微博首页', '', '1', '', '0', '1538288731', '100');
INSERT INTO `oc_user_rule` VALUES ('2', '1', 'weibo', 'weibo/index/add', '发布微博', '', '1', '', '0', '0', '101');
INSERT INTO `oc_user_rule` VALUES ('3', '1', 'weibo', 'weibo/index/sendlong', '发布长微博', '', '1', '', '0', '0', '102');

-- ----------------------------
-- Table structure for oc_picture
-- ----------------------------
DROP TABLE IF EXISTS `oc_common_picture`;
CREATE TABLE `oc_common_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `type` varchar(50) NOT NULL,
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `width` int(11) NOT NULL DEFAULT '0',
  `height` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oc_picture
-- ----------------------------

-- ----------------------------
-- Table structure for oc_user_log
-- ----------------------------
DROP TABLE IF EXISTS `oc_user_log`;
CREATE TABLE `oc_user_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `module` varchar(30) NOT NULL DEFAULT '' COMMENT '模块名',
  `action` varchar(255) NOT NULL DEFAULT '' COMMENT '方法名',
  `param` text NOT NULL COMMENT '参数 json',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'IP',
  `user_agent` varchar(255) NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `username` (`username`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='用户日志表';

-- ----------------------------
-- Records of oc_user_log
-- ----------------------------

-- ----------------------------
-- Table structure for oc_ip_black_list
-- ----------------------------
DROP TABLE IF EXISTS `oc_common_ip_black_list`;
CREATE TABLE `oc_common_ip_black_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `ip` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='IP黑名单表';

-- ----------------------------
-- Records of oc_user_log
-- ----------------------------


-- ----------------------------
-- Table structure for oc_score_type
-- ----------------------------
DROP TABLE IF EXISTS `oc_user_score_type`;
CREATE TABLE `oc_user_score_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 -1-删除 0-禁用 1-启用',
  `unit` varchar(20) NOT NULL DEFAULT '' COMMENT '单位',
  `intro` varchar(255) NOT NULL DEFAULT '' COMMENT '说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='积分类型表';

-- ----------------------------
-- Records of oc_score_type
-- ----------------------------
INSERT INTO `oc_user_score_type` VALUES ('1', '积分', '1', '分', '用户的主积分，可用于兑换奖励，可增可减');
INSERT INTO `oc_user_score_type` VALUES ('2', '威望', '1', '点', '代表用户在社区中的影响力，可增可减');
INSERT INTO `oc_user_score_type` VALUES ('3', '经验值', '1', '点', '代表用户在社区中的贡献，可增可减');
INSERT INTO `oc_user_score_type` VALUES ('4', '贡献', '1', '点', '用户累计的经验，用于统计用户的等级，一般只增不减');

-- ----------------------------
-- Table structure for oc_score_rule
-- ----------------------------
DROP TABLE IF EXISTS `oc_user_score_rule`;
CREATE TABLE `oc_user_score_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '标题',
  `rule_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户权限id',
  `change_num` tinyint(3) NOT NULL DEFAULT '0' COMMENT '积分变动数量',
  `change_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '变动方式 1-加 2-减',
  `score_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '积分类型',
  `frequency` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '频率',
  `time_unit` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '时间单位类型 1-秒 2-分钟 3-小时 4-天 5-周 6-月 7-年',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 -1-删除 0-禁用 1-启用',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `rule_id` (`rule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='积分规则表';

-- ----------------------------
-- Records of oc_score_rule
-- ----------------------------

-- ----------------------------
-- Table structure for oc_user_count
-- ----------------------------
DROP TABLE IF EXISTS `oc_user_count`;
CREATE TABLE `oc_user_count` (
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `score1` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '积分1',
  `score2` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '积分2',
  `score3` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '积分3',
  `score4` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '积分4',
  `score5` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '积分5',
  `score6` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '积分6',
  `score7` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '积分7',
  `score8` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '积分8',
  `score9` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '积分9',
  `score10` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '积分10',
  PRIMARY KEY (`uid`),
  KEY `score1` (`score1`) USING BTREE,
  KEY `score2` (`score2`) USING BTREE,
  KEY `score3` (`score3`) USING BTREE,
  KEY `score4` (`score4`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COMMENT='用户统计表';

-- ----------------------------
-- Records of oc_user_count
-- ----------------------------
