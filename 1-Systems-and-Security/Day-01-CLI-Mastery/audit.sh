#!/bin/bash
echo "=============================="
echo "     AWS EC2 AUDIT REPORT"
echo "=============================="
echo "Public IP: $(curl -s ifconfig.me)"
echo "Memory Usage:"
free -h
echo "Disk Usage:"
df -h | grep '^/dev/'
echo "Audit completed at: $(date)"
