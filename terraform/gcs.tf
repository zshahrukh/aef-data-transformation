# Copyright 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

resource "google_storage_bucket" "aef_artifacts_bucket" {
  name                     = "${var.project}_aef_artifacts_bucket"
  location                 = var.region
  project                  = var.project
  public_access_prevention = "enforced"
  force_destroy            = false
}

resource "google_storage_bucket" "aef_jobs_bucket" {
  name                     = "${var.project}_aef_jobs_bucket"
  location                 = var.region
  project                  = var.project
  public_access_prevention = "enforced"
  force_destroy            = false
}