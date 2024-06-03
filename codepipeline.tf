# ECR repository for frontend
resource "aws_ecr_repository" "sp-frontend-app-ecr" {
  name = "sp-frontend-app-ecr"
}

resource "aws_codebuild_project" "sp-frontend-app-build" {
  name            = "sp-frontend-app-build"
  service_role    = "arn:aws:iam::058264531795:role/service-role/codebuild-sp-frontend-app-service-role"
  source {
    type            = "GITHUB"
    location        = "https://github.com/murtazaa-hussainn/sp-frontend-app.git"
    buildspec       = file("${path.module}/codepipeline-scripts/frontend-buildspec.yml")
    git_clone_depth = 1
  }
  artifacts {
    type = "CODEPIPELINE"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    environment_variable {
      name  = "VITE_BACKEND_URL"
      value = "ssm:/sp/backend/url"
    }
  }
}

# CodeDeploy Application for frontend
resource "aws_codedeploy_app" "sp-frontend-app-deploy" {
  name = "sp-frontend-app-deploy"
}

# CodeDeploy Deployment Group for frontend
resource "aws_codedeploy_deployment_group" "sp-frontend-deployment-group" {
  app_name              = aws_codedeploy_app.sp-frontend-app-deploy.name
  deployment_group_name = "sp-frontend-deployment-group"
  service_role_arn      = "arn:aws:iam::058264531795:role/service-role/codebuild-sp-frontend-app-service-role" # Need to create a universal role
  deployment_config_name = "CodeDeployDefault.OneAtATime"
  
  ec2_tag_set {
    ec2_tag_filter {
      key   = "Application"
      value = "Frontend"
      type  = "KEY_AND_VALUE"
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}

resource "aws_codepipeline" "sp-frontend-app-pipeline" {
  name     = "sp-frontend-app-pipeline"
  role_arn = "arn:aws:iam::058264531795:role/service-role/codebuild-sp-frontend-app-service-role"

  artifact_store {
    location = "aws_s3_bucket.pipeline_artifacts.bucket"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        Owner  = "murtazaa-hussainn"
        Repo   = "sp-frontend-app"
        Branch = "main"
        OAuthToken = "your-github-oauth-token"
      }
    }
  }

  stage {
    name = "Build"

    action {
      version          = 0.2
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = aws_codebuild_project.sp-frontend-app-build.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      version          = 0.2
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "CodeDeploy"
      input_artifacts  = ["build_output"]
      configuration = {
        ApplicationName     = aws_codedeploy_app.sp-frontend-app-deploy.name
        DeploymentGroupName = aws_codedeploy_deployment_group.sp-frontend-deployment-group.deployment_group_name
      }
    }
  }
}

# ECR repository for backend
resource "aws_ecr_repository" "sp-backend-app-ecr" {
  name = "sp-backend-app-ecr"
}

resource "aws_codebuild_project" "sp-backend-app-build" {
  name            = "sp-backend-app-build"
  service_role    = "arn:aws:iam::058264531795:role/service-role/codebuild-sp-backend-app-service-role"
  source {
    type            = "GITHUB"
    location        = "https://github.com/murtazaa-hussainn/sp-backend-app.git"
    buildspec       = file("${path.module}/codepipeline-scripts/backend-buildspec.yml")
    git_clone_depth = 1
  }
  artifacts {
    type = "CODEPIPELINE"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    environment_variable {
      name  = "DB_CREDENTIALS"
      value = "ssm:/sp/db/credentials"
    }
  }
}

# CodeDeploy Application for backend
resource "aws_codedeploy_app" "sp-backend-app-deploy" {
  name = "sp-backend-app-deploy"
}

# CodeDeploy Deployment Group for backend
resource "aws_codedeploy_deployment_group" "sp-backend-deployment-group" {
  app_name              = aws_codedeploy_app.sp-backend-app-deploy.name
  deployment_group_name = "sp-backend-deployment-group"
  service_role_arn      = "arn:aws:iam::058264531795:role/service-role/codebuild-sp-backend-app-service-role"
  deployment_config_name = "CodeDeployDefault.OneAtATime"

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Application"
      value = "Backend"
      type  = "KEY_AND_VALUE"
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}

resource "aws_codepipeline" "sp-backend-app-pipeline" {
  name     = "sp-backend-app-pipeline"
  role_arn = "arn:aws:iam::058264531795:role/service-role/codebuild-sp-backend-app-service-role"

  artifact_store {
    location = "aws_s3_bucket.pipeline_artifacts.bucket"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        Owner  = "murtazaa-hussainn"
        Repo   = "sp-frontend-app"
        Branch = "main"
        OAuthToken = "your-github-oauth-token"
      }
    }
  }

  stage {
    name = "Build"

    action {
      version          = 0.2
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = aws_codebuild_project.sp-backend-app-build.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      version          = 0.2
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "CodeDeploy"
      input_artifacts  = ["build_output"]
      configuration = {
        ApplicationName     = aws_codedeploy_app.sp-backend-app-deploy.name
        DeploymentGroupName = aws_codedeploy_deployment_group.sp-backend-deployment-group.deployment_group_name
      }
    }
  }
}