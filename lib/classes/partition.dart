class Partition {
  String partition;
  String mountpoint;
  String filesystem;

  Partition({
    this.partition = "",
    this.mountpoint = "none",
    this.filesystem = "don't format",
  });
}
