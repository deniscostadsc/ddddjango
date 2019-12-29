import datetime

from freezegun import freeze_time

from entities.post import Post


@freeze_time("2000-01-01 00:00:00")
def test_post_creation():
    content = "Lorem Ipsum"
    tags = ["lorem", "ipsum"]

    post = Post(content, tags=tags)

    assert post.created_at == datetime.datetime(2000, 1, 1, 0, 0, 0, 0)


@freeze_time("2000-01-01 00:00:00")
def test_post_publishing():
    content = "Lorem Ipsum"
    tags = ["lorem", "ipsum"]

    post = Post(content, tags=tags)
    assert post.publishing_date is None

    post.publish()
    assert post.publishing_date == datetime.datetime(2000, 1, 1, 0, 0, 0, 0)


@freeze_time("2000-01-01 00:00:00")
def test_post_hide():
    content = "Lorem Ipsum"
    tags = ["lorem", "ipsum"]

    post = Post(content, tags=tags)
    assert post.publishing_date is None

    post.publish()
    assert post.publishing_date == datetime.datetime(2000, 1, 1, 0, 0, 0, 0)

    post.hide()
    assert post.publishing_date is None
