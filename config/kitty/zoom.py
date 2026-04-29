#! /usr/bin/env python3

from kitty.boss import Boss

ZOOM_COLOR = "#ff0000"
NORMAL_COLOR = "#32cd32"

def update_border(boss: Boss):
  tab = boss.active_tab
  if tab is None:
    return
  is_stacked = tab.current_layout.name == "stack"
  color = ZOOM_COLOR if is_stacked else NORMAL_COLOR
  boss.call_remote_control(boss.active_window, (
    "load-config", "-o",
    f"draw_window_borders_for_single_window={'yes' if is_stacked else 'no'}"
  ))
  boss.set_colors(f"active_border_color={color}")


def main(args: list[str]):
  pass

from kittens.tui.handler import result_handler
@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
  tab = boss.active_tab
  if tab is not None:
    tab.toggle_layout("stack")
  update_border(boss)

def on_focus_change(boss: Boss, window, data: dict):
  update_border(boss)
