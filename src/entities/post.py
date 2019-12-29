import datetime


class Post:
    def __init__(self, content, publishing_date=None, tags=None):
        self.content = content
        self.tags = tags
        self.created_at = datetime.datetime.now()
        self.publishing_date = publishing_date

    def publish(self):
        self.publishing_date = datetime.datetime.now()

    def hide(self):
        self.publishing_date = None
