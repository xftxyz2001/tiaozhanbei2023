-- 1.用户表
-- 字段：用户ID、用户名、密码、性别、生日、手机号、邮箱、创建时间、修改时间
CREATE TABLE user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    gender ENUM('男', '女') NOT NULL,
    birthday DATE,
    phone VARCHAR(20),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- 2.家庭成员表
-- 字段：成员ID、家庭ID、用户ID、头像、昵称、性别、生日、手机、邮箱、是否管理员、状态、创建时间、修改时间
CREATE TABLE family_member (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    family_id INT NOT NULL,
    user_id INT NOT NULL,
    avatar VARCHAR(100),
    nickname VARCHAR(50),
    gender ENUM('男', '女'),
    birthday DATE,
    phone VARCHAR(20),
    email VARCHAR(100),
    is_admin BOOL,
    status ENUM('正常', '离开', '请假'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (family_id) REFERENCES family(family_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);
-- 3.家庭活动表
-- 字段：活动ID、家庭ID、发起者ID、活动名称、活动类型、活动开始时间、活动结束时间、参与人数、评论数、点赞数、创建时间、修改时间
CREATE TABLE family_activity (
    activity_id INT PRIMARY KEY AUTO_INCREMENT,
    family_id INT NOT NULL,
    initiator_id INT NOT NULL,
    activity_name VARCHAR(100) NOT NULL,
    activity_type VARCHAR(50),
    start_time DATETIME,
    end_time DATETIME,
    participant_count INT DEFAULT 0,
    comment_count INT DEFAULT 0,
    like_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (family_id) REFERENCES family(family_id),
    FOREIGN KEY (initiator_id) REFERENCES family_member(member_id)
);
-- 4.家庭活动参与表
-- 字段：参与ID、家庭ID、活动ID、参与者ID、是否参与、留言、评分、创建时间、修改时间
CREATE TABLE activity_participant (
    participant_id INT PRIMARY KEY AUTO_INCREMENT,
    family_id INT NOT NULL,
    activity_id INT NOT NULL,
    participant_id INT NOT NULL,
    is_participated BOOL,
    message TEXT,
    rating INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (family_id) REFERENCES family(family_id),
    FOREIGN KEY (activity_id) REFERENCES family_activity(activity_id),
    FOREIGN KEY (participant_id) REFERENCES family_member(member_id)
);
-- 5.家庭信息表
-- 字段：信息ID、家庭ID、发送者ID、接收者ID、消息内容、消息类型、发送时间、是否已读、创建时间、修改时间
CREATE TABLE family_message (
    message_id INT PRIMARY KEY AUTO_INCREMENT,
    family_id INT NOT NULL,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    message_content TEXT,
    message_type ENUM('短信', '语音', '电话', '视频'),
    sent_time DATETIME,
    is_read BOOL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (family_id) REFERENCES family(family_id),
    FOREIGN KEY (sender_id) REFERENCES family_member(member_id),
    FOREIGN KEY (receiver_id) REFERENCES family_member(member_id)
);
-- 6.记录时刻表
-- 字段：时刻ID、家庭ID、发布者ID、时刻内容、发布类型（文字/图片/语音）、点赞数、评论数、创建时间、修改时间
CREATE TABLE moment (
    moment_id INT PRIMARY KEY AUTO_INCREMENT,
    family_id INT NOT NULL,
    publisher_id INT NOT NULL,
    moment_content TEXT,
    moment_type ENUM('文字', '图片', '语音'),
    like_count INT DEFAULT 0,
    comment_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (family_id) REFERENCES family(family_id),
    FOREIGN KEY (publisher_id) REFERENCES family_member(member_id)
);
-- 7.记录时刻评论表
-- 字段：评论ID、家庭ID、时刻ID、评论者ID、评论内容、点赞数、创建时间、修改时间
CREATE TABLE moment_comment (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    family_id INT NOT NULL,
    moment_id INT NOT NULL,
    commenter_id INT NOT NULL,
    comment_content TEXT,
    like_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (family_id) REFERENCES family(family_id),
    FOREIGN KEY (moment_id) REFERENCES moment(moment_id),
    FOREIGN KEY (commenter_id) REFERENCES family_member(member_id)
);
-- 8.匿名小纸条表
-- 字段：小纸条ID、家庭ID、发送者ID、接收者ID、纸条内容、创建时间
CREATE TABLE anonymous_note (
    note_id INT PRIMARY KEY AUTO_INCREMENT,
    family_id INT NOT NULL,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    note_content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (family_id) REFERENCES family(family_id),
    FOREIGN KEY (sender_id) REFERENCES family_member(member_id),
    FOREIGN KEY (receiver_id) REFERENCES family_member(member_id)
);
-- 9.我的喜欢表
-- 字段：喜欢ID、家庭ID、用户ID、类型（文章/音乐/视频）、内容ID、创建时间、修改时间
CREATE TABLE my_favorite (
    favorite_id INT PRIMARY KEY AUTO_INCREMENT,
    family_id INT NOT NULL,
    user_id INT NOT NULL,
    favorite_type ENUM('文章', '音乐', '视频'),
    content_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (family_id) REFERENCES family(family_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);
-- 10.我的收藏表
-- 字段：收藏ID、家庭ID、用户ID、类型（文史资料/名家书画/国际奖项）、内容ID、创建时间、修改时间
CREATE TABLE my_collection (
    collection_id INT PRIMARY KEY AUTO_INCREMENT,
    family_id INT NOT NULL,
    user_id INT NOT NULL,
    collection_type ENUM('文史资料', '名家书画', '国际奖项'),
    content_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (family_id) REFERENCES family(family_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);
-- 11.家庭族谱表
-- 字段：族谱ID、家庭ID、成员ID、父辈ID、母辈ID、姓名、头像、关系、描述信息、创建时间、修改时间
CREATE TABLE family_tree (
    tree_id INT PRIMARY KEY AUTO_INCREMENT,
    family_id INT NOT NULL,
    member_id INT NOT NULL,
    father_id INT,
    mother_id INT,
    name VARCHAR(50),
    avatar VARCHAR(100),
    relationship VARCHAR(50),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (family_id) REFERENCES family(family_id),
    FOREIGN KEY (member_id) REFERENCES family_member(member_id),
    FOREIGN KEY (father_id) REFERENCES family_member(member_id),
    FOREIGN KEY (mother_id) REFERENCES family_member(member_id)
);
-- 12.谱写生平表
-- 字段：人物ID、家庭ID、用户ID、人物姓名、人物头像、生平内容、录入方式（键盘/语音）、创建时间、修改时间
CREATE TABLE life_story (
    story_id INT PRIMARY KEY AUTO_INCREMENT,
    family_id INT NOT NULL,
    user_id INT NOT NULL,
    person_name VARCHAR(100) NOT NULL,
    avatar VARCHAR(100),
    life_content TEXT,
    input_method ENUM('键盘', '语音'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (family_id) REFERENCES family(family_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);