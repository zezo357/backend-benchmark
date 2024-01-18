from locust import HttpUser, task, between

class NoteUser(HttpUser):
    wait_time = between(1, 2)

    @task
    def write_note(self):
        self.client.post("/notes/", json={
            "title": "Sample Note",
            "content": "This is a note content."
        })

    @task
    def read_notes(self):
        self.client.get("/notes/")