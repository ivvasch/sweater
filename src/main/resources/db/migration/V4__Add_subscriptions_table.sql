CREATE TABLE user_subscription
(
    chanel_id     INT8 NOT NULL REFERENCES usr,
    cubscriber_id INT8 NOT NULL REFERENCES usr,
    PRIMARY KEY (chanel_id, cubscriber_id)
)