import 'package:flutter/material.dart';
import 'package:jade_gui/functions/partitioning/auto.dart';
import 'package:jade_gui/functions/partitioning/manual.dart';

Widget partitioning(
    disks,
    setState,
    setPartition,
    next,
    setPartitionInfo,
    selectedPartition,
    partitionInfo,
    runningPart,
    setRunningPart,
    runningInfo,
    setRunningInfo,
    doManualPartitioning,
    setManual,
    runningPartMan,
    runningInfoMan,
    setRunningPartMan,
    setRunningInfoMan,
    setPartitions,
    partitions,
    setPartitionMountPoint,
    setFilesystem,
    efi) {
  if (doManualPartitioning) {
    setRunningInfoMan(false);
    return manualPartitioning(
      partitions,
      setPartitions,
      runningPartMan,
      setRunningPartMan,
      runningInfoMan,
      setRunningInfoMan,
      setPartitionMountPoint,
      setManual,
      next,
      setFilesystem,
      efi,
      selectedPartition,
      disks,
      setState,
      runningPart,
      setRunningPart,
      setPartition,
    );
  } else {
    setRunningInfo(false);
    setRunningPart(false);
    return autoPartitioning(
        disks,
        setState,
        setPartition,
        next,
        setPartitionInfo,
        selectedPartition,
        partitionInfo,
        runningPart,
        setRunningPart,
        runningInfo,
        setRunningInfo,
        setManual);
  }
}
