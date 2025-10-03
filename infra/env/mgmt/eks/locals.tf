locals {
  private_subnets = {
    for k, v in data.terraform_remote_state.network.outputs.subnet_ids :
    k => v if can(regex("private", k))
  }
}
