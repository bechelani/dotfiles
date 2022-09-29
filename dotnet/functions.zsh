function get_dotnet_version() {
  dotnet --version | awk '{print $1 " " $2}'
}

function prompt_get_dotnet_version() {
  get_dotnet_version
}
