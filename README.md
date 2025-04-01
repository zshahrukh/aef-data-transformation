# Analytics Engineering Framework - Data Transformation
***Note:*** For a comprehensive installation guide of all the AEF repositories together, please look [here](https://github.com/googlecloudplatform/aef-orchestration-framework/blob/main/AEF_DEPLOYMENT.md).

[Analytics engineers](https://www.getdbt.com/what-is-analytics-engineering) lay the foundation for others to organize, transform, and document data using software engineering principles. Providing easy to use data platforms that empower data practitioners to independently build data pipelines in a standardized and scalable way, and answer their own data-driven questions.

This opinionated data transformation management repository can be used independently to define, store, and deploy data transformation definitions. However, is designed as a component within a comprehensive Analytics Engineering Framework comprising:
1. [Orchestration Framework](https://github.com/googlecloudplatform/aef-orchestration-framework): Maintained by Analytics Engineers to provide seamless, extensible orchestration and execution infrastructure.
1. [Data Model](https://github.com/googlecloudplatform/aef-data-model): Directly used by end data practitioners to manage data models, schemas, and Dataplex metadata.
1. [Data Orchestration](https://github.com/googlecloudplatform/aef-data-orchestration): Directly used by end data practitioners to define and deploy data pipelines using levels, threads, and steps.
1. **(This repository) Data Transformation**: Directly used by end data practitioners to define, store, and deploy data transformations.
![AEF_repositories.png](AEF_repositories.png)

### Repository
This repository is a central location for storing and deploy artifacts necessary for your data transformations, such as JDBC drivers and compiled JAR dependencies. However, its core function is to maintain configuration files that define your transformations. These JSON, YAML, or similar parameter files are referenced as reusable steps in your data pipelines, and are interpreted by the execution infrastructure within the Orchestration framework.

![data_processing_repo.png](data_processing_repo.png)
```
├── artifacts
│   ├── dataporc
│   │   └── custom_dependency.jar
│   ├── jdbcjars
│   │   └── postgresql.jar
│   └── ...
└── jobs
    ├── dev
    │   ├── dataflow-flextemplate-job-executor
    │   │   └── sample_jdbc_dataflow_ingestion.json
    │   │   └── ...        
    │   ├── dataform-tag-executor
    │   │   └── run_dataform_tag.json
    │   │   └── ... 
    │   ├── dataproc-serverless-job-executor
    │   └── ...
    ├── prod
    └── ...
```

### Terraform:
1. Define your terraform variables
<!-- BEGIN TFDTFOC -->
| name                                        | description                                                                                                                                                   | type     | required | default |
|---------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|----------|---------|
| [domain](terraform/variables.tf#L17)        | Your organization or domain name, organization if centralized data management, domain name if one repository for each data domain in a Data mesh environment. | string   | true     | -       |
| [project](terraform/variables.tf#L23)       | The project where the GCS buckets for storing your artifacts and job definitions will be created.                                                             | string   | true     | -       |
| [region](terraform/variables.tf#L29)        | The region where the GCS buckets for storing your artifacts and job definitions will be created.                                                              | string   | true     | -       |
| [environment](terraform/variables.tf#L35)   | Environment folder name you want to deploy. ../jobs/$ENVIRONMENT/.. If not set wherever is in the dev environment folder will be deployed.                    | string   | false    | dev     |
<!-- END TFDOC -->
2. Run the Terraform Plan / Apply using the variables you defined.
```bash
terraform plan -var 'project=<PROJECT>' -var 'region=<REGION>' -var 'domain=<DOMAIN_NAME>' -var 'environment=dev'
```

## Usage
While this repository can be used to keep track of your dependencies and data transformation definitions, the provided terraform code can be used to control deployment, but you can deploy it as another step in your CI/CD pipeline instead.
1. Place and commit your artifacts.
2. Place and commit your job definition parameter files.
3. Define your terraform variables and deploy (plan/apply).
