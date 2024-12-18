/*
 Navicat Premium Data Transfer

 Source Server         : mysql01
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : elder

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 30/11/2024 22:15:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for elderly_health_records
-- ----------------------------
DROP TABLE IF EXISTS `elderly_health_records`;
CREATE TABLE `elderly_health_records`  (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `elderly_id` bigint(20) NOT NULL,
  `record_type` enum('体检报告','病史记录','日常数据') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `blood_pressure` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `heart_rate` int(11) NULL DEFAULT NULL,
  `blood_sugar` decimal(5, 2) NULL DEFAULT NULL,
  `weight` decimal(5, 2) NULL DEFAULT NULL,
  `height` decimal(5, 2) NULL DEFAULT NULL,
  `bmi` decimal(4, 2) NULL DEFAULT NULL,
  `diagnosis` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `medication` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `allergies` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `temperature` decimal(4, 1) NULL DEFAULT NULL,
  `sleep_hours` decimal(4, 1) NULL DEFAULT NULL,
  `exercise_minutes` int(11) NULL DEFAULT NULL,
  `record_date` datetime(0) NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`record_id`) USING BTREE,
  INDEX `idx_elderly_id`(`elderly_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of elderly_health_records
-- ----------------------------
INSERT INTO `elderly_health_records` VALUES (1, 1001, '体检报告', '120/80', 75, 5.60, 65.50, 168.00, 23.20, '血压正常，血糖偏高', '二甲双胍 500mg 每日两次', '青霉素过敏', 36.5, NULL, NULL, '2024-03-15 09:30:00', '2024-11-24 21:25:15', '2024-11-24 21:25:15');
INSERT INTO `elderly_health_records` VALUES (2, 1001, '病史记录', NULL, NULL, NULL, NULL, NULL, NULL, '2型糖尿病，高血压病史', '拜新同 5mg 每日一次；二甲双胍 500mg 每日两次', '青霉素过敏', NULL, NULL, NULL, '2024-03-10 14:20:00', '2024-11-24 21:25:15', '2024-11-24 21:25:15');
INSERT INTO `elderly_health_records` VALUES (3, 1001, '日常数据', '125/85', 78, 6.20, NULL, NULL, NULL, NULL, NULL, NULL, 36.6, 7.5, 30, '2024-03-16 08:00:00', '2024-11-24 21:25:15', '2024-11-24 21:25:15');
INSERT INTO `elderly_health_records` VALUES (4, 1002, '体检报告', '135/85', 82, 4.80, 70.20, 172.00, 23.70, '轻度高血压，建议定期监测', '络活喜 2.5mg 每日一次', '无', 36.7, NULL, NULL, '2024-03-14 10:15:00', '2024-11-24 21:25:15', '2024-11-24 21:25:15');
INSERT INTO `elderly_health_records` VALUES (5, 1002, '日常数据', '130/82', 80, 5.00, NULL, NULL, NULL, NULL, NULL, NULL, 36.5, 6.5, 45, '2024-03-16 07:30:00', '2024-11-24 21:25:15', '2024-11-24 21:25:15');
INSERT INTO `elderly_health_records` VALUES (6, 1003, '体检报告', '118/75', 68, 5.20, 58.50, 160.00, 22.90, '各项指标正常', NULL, '海鲜过敏', 36.4, NULL, NULL, '2024-03-13 14:45:00', '2024-11-24 21:25:15', '2024-11-24 21:25:15');
INSERT INTO `elderly_health_records` VALUES (7, 1003, '病史记录', NULL, NULL, NULL, NULL, NULL, NULL, '骨质疏松', '钙片 每日两次；维生素D3 每日一次', '海鲜过敏', NULL, NULL, NULL, '2024-03-12 09:20:00', '2024-11-24 21:25:15', '2024-11-24 21:25:15');
INSERT INTO `elderly_health_records` VALUES (8, 1003, '日常数据', '120/76', 70, 5.10, NULL, NULL, NULL, NULL, NULL, NULL, 36.5, 8.0, 60, '2024-03-16 08:15:00', '2024-11-24 21:25:15', '2024-11-24 21:25:15');
INSERT INTO `elderly_health_records` VALUES (13, 1004, '体检报告', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-11-24 23:30:25', '2024-11-24 23:30:24', '2024-11-24 23:30:24');

-- ----------------------------
-- Table structure for health_education_materials
-- ----------------------------
DROP TABLE IF EXISTS `health_education_materials`;
CREATE TABLE `health_education_materials`  (
  `material_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `category` enum('疾病预防','生活方式指南','营养','锻炼','心理健康') CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `target_audience` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `key_points` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `author` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `publish_date` date NULL DEFAULT NULL,
  `last_review_date` date NULL DEFAULT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`material_id`) USING BTREE,
  INDEX `idx_category`(`category`) USING BTREE,
  INDEX `idx_publish_date`(`publish_date`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of health_education_materials
-- ----------------------------
INSERT INTO `health_education_materials` VALUES (1, '老年人糖尿病日常管理指南', '疾病预防', '糖尿病是一种常见的代谢性疾病，老年人应该特别注意血糖的监测和控制。日常生活中要注意饮食规律，适量运动，按时服药。', '糖尿病老年患者', '1. 血糖监测要点\n2. 饮食注意事项\n3. 运动建议\n4. 并发症预防', '张医生', '2024-03-01', '2024-03-10', '2024-11-24 21:25:38', '2024-11-24 21:25:38');
INSERT INTO `health_education_materials` VALUES (2, '健康饮食与营养均衡', '营养', '合理的饮食对老年人的健康至关重要。应该注意营养均衡，适量摄入蛋白质，控制盐分和油脂的摄入。', '所有老年人', '1. 营养搭配原则\n2. 食物选择指南\n3. 注意事项', '李营养师', '2024-03-05', '2024-03-15', '2024-11-24 21:25:38', '2024-11-24 21:25:38');
INSERT INTO `health_education_materials` VALUES (3, '老年人居家运动指南', '锻炼', '科学的运动可以提高老年人的身体素质，预防疾病。运动时要注意循序渐进，选择适合自己的运动方式。', '行动能力正常的老年人', '1. 适合老年人的运动项目\n2. 运动注意事项\n3. 运动强度控制', '王教练', '2024-03-08', '2024-03-18', '2024-11-24 21:25:38', '2024-11-24 21:25:38');
INSERT INTO `health_education_materials` VALUES (4, '老年人心理健康指南', '心理健康', '随着年龄增长，老年人可能面临各种心理问题。保持积极乐观的心态，培养兴趣爱好，保持社交活动很重要。', '所有老年人', '1. 心理调适方法\n2. 压力管理\n3. 社交建议', '刘心理咨询师', '2024-03-12', '2024-03-20', '2024-11-24 21:25:38', '2024-11-24 21:25:38');
INSERT INTO `health_education_materials` VALUES (5, '老年人高血压防治指南', '疾病预防', '高血压是老年人常见的慢性病，需要长期坚持治疗和管理。日常生活中要注意监测血压，合理用药。', '高血压老年患者', '1. 血压监测方法\n2. 用药指导\n3. 生活方式调整\n4. 危险因素控制', '陈医生', '2024-03-15', '2024-03-22', '2024-11-24 21:25:38', '2024-11-24 21:25:38');

-- ----------------------------
-- Table structure for health_recommendations
-- ----------------------------
DROP TABLE IF EXISTS `health_recommendations`;
CREATE TABLE `health_recommendations`  (
  `recommendation_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `elderly_id` bigint(20) NOT NULL,
  `record_id` bigint(20) NULL DEFAULT NULL,
  `health_status` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `risk_level` enum('低','中','高') CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `dietary_advice` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `exercise_plan` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `medication_reminder` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `lifestyle_suggestions` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `next_checkup_date` date NULL DEFAULT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`recommendation_id`) USING BTREE,
  INDEX `record_id`(`record_id`) USING BTREE,
  INDEX `idx_elderly_id`(`elderly_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of health_recommendations
-- ----------------------------
INSERT INTO `health_recommendations` VALUES (1, 1001, 1, '血糖控制需要加强', '中', '1. 控制碳水化合物摄入\n2. 增加膳食纤维\n3. 少食多餐，定时定量', '1. 每天步行30分钟\n2. 太极拳练习\n3. 避免剧烈运动', '请按时服用降糖药物，饭后2小时测量血糖', '保持作息规律，避免熬夜，控制情绪，定期监测血压血糖', '2024-04-15', '2024-11-24 21:25:30', '2024-11-24 21:25:30');
INSERT INTO `health_recommendations` VALUES (2, 1002, 4, '血压需要持续监测', '中', '1. 控制钠盐摄入\n2. 增加钾的摄入\n3. 限制咖啡因', '1. 每天快走45分钟\n2. 游泳或水中运动\n3. 循序渐进增加运动量', '按时服用降压药，每天测量血压', '保持心情舒畅，避免剧烈情绪波动，保证充足睡眠', '2024-04-10', '2024-11-24 21:25:30', '2024-11-24 21:25:30');
INSERT INTO `health_recommendations` VALUES (3, 1003, 6, '骨质疏松需要预防', '低', '1. 补充钙质和维生素D\n2. 多吃豆制品和深绿色蔬菜\n3. 适量晒太阳', '1. 负重运动\n2. 广场舞\n3. 散步', '按时服用钙片和维生素D', '多到户外活动，保持适度运动，避免跌倒', '2024-04-20', '2024-11-24 21:25:30', '2024-11-24 21:25:30');
INSERT INTO `health_recommendations` VALUES (5, 1004, NULL, '低', '低', '的温柔分', '发到企鹅人', NULL, ' 放大器二分 ', '2024-11-24', '2024-11-24 23:34:28', '2024-11-24 23:34:28');
INSERT INTO `health_recommendations` VALUES (6, 1004, NULL, '饿啊日地方额', '低', '二分而且', '人的全额瓦', NULL, ' 请问', '2024-11-24', '2024-11-24 23:38:27', '2024-11-24 23:38:27');

SET FOREIGN_KEY_CHECKS = 1;
