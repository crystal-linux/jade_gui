class Partition {
  final String partition;
  String mountpoint;
  String filesystem;

  Partition({
    this.partition = "",
    this.mountpoint = "none",
    this.filesystem = "",
  });
}
