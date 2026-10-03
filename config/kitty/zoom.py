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

  tab.current_layout.must_draw_borders = is_stacked
  tab.relayout()

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
