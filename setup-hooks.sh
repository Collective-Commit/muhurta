#!/bin/sh
# Script to set up Git hooks

# Copy the custom hooks to the .git/hooks directory and make them executable
cp git-hooks/* .git/hooks/
chmod +x .git/hooks/*
