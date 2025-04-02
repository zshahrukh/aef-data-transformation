/**
 * Copyright 2025 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
provider "google-beta" {
  project = var.project
  region  = var.region
}

#project reference to get project number
data "google_project" "project" {
  project_id = var.project
}

resource "google_storage_bucket_object" "uploaded_artifacts" {
  for_each = fileset("../artifacts/", "**/*")
  name     = each.key
  bucket   = google_storage_bucket.aef_artifacts_bucket.name
  source   = "../artifacts/${each.key}"
}

resource "google_storage_bucket_object" "uploaded_jobs" {
  for_each = fileset(format("../jobs/%s/", var.environment), "**/*")

  # Extract filename from the full path (removing the environment subfolder)
  name   = replace(each.key, format("../jobs/%s/", var.environment), "")
  bucket       = google_storage_bucket.aef_jobs_bucket.name
  # Use the full path for the source
  source = format("../jobs/%s/%s", var.environment, each.key)
}
