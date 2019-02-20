$dir = "solr" #where to mount ebs
case $::ec2_block_device_mapping_ebs2 {
  'sdb': { $dev = "xvdb" }
  'sdc': { $dev = "xvdc" }
  'sdd': { $dev = "xvdd" }
  'sde': { $dev = "xvde" }
  'sdf': { $dev = "xvdf" }
  'sdg': { $dev = "xvdg" }
  'sdh': { $dev = "xvdh" }
  'sdi': { $dev = "xvdi" }
  'sdj': { $dev = "xvdj" }
  'sdk': { $dev = "xvdk" }
  'sdl': { $dev = "xvdl" }
  default: { $dev = "null" }
}

node 'localhost.localdomain' {
	#class { "lighthouse_principal_appserver": }
	
	exec { "/sbin/mkfs.ext3 -m0 /dev/$dev":
	cwd => "/",
	unless => '/sbin/fsck -M -y /dev/$dev',
  	}
	file { "/$dir":
	ensure => directory,
	owner => root,
	group => root,
	mode => 755
	}
  mount { "$dir":
	device => "/dev/$dev",
	name   => "/$dir",
	ensure => mounted,
	fstype => ext3,
	options => 'defaults,noatime',
	require => File["/$dir"],
	}
}
