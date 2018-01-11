function get_dotnet_version() {
  dotnet --version | awk '{print $1 " " $2}'
}
