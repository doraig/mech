#!/usr/bin/env bats
#
# shared_folders.bats - run shared_folders tests
#
# Note: must be run from this directory
# like this: ./shared_folders.bats

@test "shared folders testing" {
  cd provision

  # setup
  find . -type d -name .mech -exec rm -rf {} \; 2> /dev/null || true

  run mech up
  regex1="VM (first) started"
  [ "$status" -eq 0 ]
  [[ "$output" =~ $regex1 ]]

  run mech ssh -c "ls -al /mnt/hgfs/mech/Mechfile" first
  regex1="Mechfile"
  [ "$status" -eq 0 ]
  [[ "$output" =~ $regex1 ]]

  run mech stop
  regex1="Stopped"
  [ "$status" -eq 0 ]
  [[ "$output" =~ $regex1 ]]

  run mech up --disable-shared-folders
  regex1="VM (first) started"
  [ "$status" -eq 0 ]
  [[ "$output" =~ $regex1 ]]

  run mech ssh -c "ls -al /mnt/hgfs/mech/Mechfile" first
  regex1="No such file or directory"
  [ "$status" -eq 1 ]
  [[ "$output" =~ $regex1 ]]

  run mech pause
  regex1="Paused"
  [ "$status" -eq 0 ]
  [[ "$output" =~ $regex1 ]]

  run mech resume --disable-shared-folders
  regex1="VM (first) started"
  [ "$status" -eq 0 ]
  [[ "$output" =~ $regex1 ]]

  run mech ssh -c "ls -al /mnt/hgfs/mech/Mechfile" first
  regex1="No such file or directory"
  [ "$status" -eq 1 ]
  [[ "$output" =~ $regex1 ]]

  run mech pause
  regex1="Paused"
  [ "$status" -eq 0 ]
  [[ "$output" =~ $regex1 ]]

  run mech resume
  regex1="VM (first) started"
  [ "$status" -eq 0 ]
  [[ "$output" =~ $regex1 ]]

  run mech ssh -c "ls -al /mnt/hgfs/mech/Mechfile" first
  regex1="Mechfile"
  [ "$status" -eq 0 ]
  [[ "$output" =~ $regex1 ]]

  run mech destroy -f
  regex1="Deleting"
  [ "$status" -eq 0 ]
  [[ "$output" =~ $regex1 ]]

  # clean up
  find . -type d -name .mech -exec rm -rf {} \; 2> /dev/null || true

  cd ..
}