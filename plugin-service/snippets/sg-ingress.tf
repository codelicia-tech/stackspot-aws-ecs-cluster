
  ingress {
    from_port   = {{port}}
    to_port     = {{port}}
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }