#######################################################################################################################
# Create kubescreen repository
module "kubescreen" {
  source = "./tf-modules/github-repo.tf"
  
  name = kubescreen
}

module "payment-app" {
  source = "./tf-modules/github-repo.tf"
  
  name = payment-app
}
