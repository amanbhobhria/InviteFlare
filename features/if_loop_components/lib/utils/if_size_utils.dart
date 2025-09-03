part of '../if_loop_components.dart';

double getSpace({required IFSpaces space}) {
  return switch (space) {
    IFSpaces.xxxS => 8,
    IFSpaces.xxS => 10,
    IFSpaces.xS => 12,
    IFSpaces.S => 14,
    IFSpaces.M => 16,
    IFSpaces.L => 18,
    IFSpaces.xL => 20,
    IFSpaces.xxL => 24,
    IFSpaces.xxxL => 28,
    IFSpaces.xxxxL => 32,
    IFSpaces.xxxxxL => 48,
    IFSpaces.xxxxxxL => 56,
  };
}
