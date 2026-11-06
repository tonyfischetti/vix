// gleam, filesystem, get file info, stat, file size, modification time, mtime, permissions, file type, simplifile

// gleam add simplifile gleam_time

import gleam/int
import gleam/time/calendar
import gleam/time/timestamp
import simplifile

pub fn main() {
  // has size, mode, nlinks, inode, user_id, group_id, dev, atime_seconds,
  // mtime_seconds and ctime_seconds
  let assert Ok(info) = simplifile.file_info("gleam.toml")
  echo info
  // FileInfo(1376, 33188, 1, 83002010, 501, 0, 16777234, 1793921582,
  //   1793921554, 1793921554)

  // in bytes
  echo info.size
  // 1376

  assert simplifile.file_info_type(info) == simplifile.File

  // the permissions, the way `ls` and `chmod` talk about them
  echo info |> simplifile.file_info_permissions_octal |> int.to_base8
  // "644"

  // the times are unix seconds
  echo info.mtime_seconds
    |> timestamp.from_unix_seconds
    |> timestamp.to_rfc3339(calendar.local_offset())
  // "2026-11-05T18:32:34-05:00"

  let assert Ok(src) = simplifile.file_info("src")
  assert simplifile.file_info_type(src) == simplifile.Directory

  assert simplifile.file_info("no such file") == Error(simplifile.Enoent)
  //  NOTE  `file_info` follows symbolic links. `link_info` is the same
  //        thing but tells you about the link itself
}
