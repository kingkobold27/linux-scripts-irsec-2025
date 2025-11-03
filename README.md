# linux-scripts-irsec-2025
scripts for comps, very early, very ass, mostly vibe coded :wilted_rose:


 ┌──────────────────────────────┐
 │ Start Script (#!/bin/bash)  │
 └──────────────┬───────────────┘
                │
                ▼
 ┌──────────────────────────────┐
 │ Ask for username (read -p)  │
 └──────────────┬───────────────┘
                │
                ▼
 ┌──────────────────────────────┐
 │ Check if user exists (id)   │
 └──────────────┬───────────────┘
        ┌───────┴────────────┐
        │                    │
        ▼                    ▼
 ┌─────────────────┐   ┌────────────────────┐
 │ User exists     │   │ User does NOT exist│
 │ Proceed...      │   │ Print message &    │
 │                 │   │ exit (exit 1)      │
 └──────┬──────────┘   └────────────────────┘
        │
        ▼
 ┌──────────────────────────────┐
 │ Loop: ask for password twice │
 │  - read -s hides input       │
 │  - compare entries           │
 └──────────────┬───────────────┘
        ┌───────┴────────────┐
        │                    │
        ▼                    ▼
 ┌─────────────────┐   ┌──────────────────────┐
 │ Passwords match │   │ Passwords don't match│
 │ break loop      │   │ echo "try again"     │
 └──────┬──────────┘   └──────────────┬───────┘
        │                             │
        └─────────────┬───────────────┘
                      │ (loop repeats)
                      ▼
 ┌────────────────────────────────┐
 │ Send "username:password" →     │
 │   sudo chpasswd via a pipe     │
 │   (updates password silently)  │
 └──────────────┬─────────────────┘
                │
                ▼
 ┌────────────────────────────────┐
 │ Check exit code $?             │
 │  - 0 = success                 │
 │  - else = failure              │
 └──────────────┬─────────────────┘
        ┌───────┴────────────┐
        │                    │
        ▼                    ▼
 ┌─────────────────┐   ┌─────────────────┐
 │ Success message │   │ Error message   │
 │ "Password changed!"│ │ "Failed to..." │
 └──────────────┬────┘   └──────┬────────┘
                │                │
                └──────┬─────────┘
                       ▼
              ┌─────────────────┐
              │     END         │
              └─────────────────┘
