provider "google" {
  credentials = file("../projectforclass-433716-666a63bb99c7.json")

  project = "projectforclass-433716"
  region = "us-central1"
  zone   = "us-central1-a"
}
