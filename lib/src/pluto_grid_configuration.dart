import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class PlutoGridConfiguration {
  /// When you select a value in the pop-up grid, it moves down.
  final bool enableMoveDownAfterSelecting;

  /// Moves the current cell when focus reaches the left or right edge in the edit state.
  final bool enableMoveHorizontalInEditing;

  /// [PlutoEnterKeyAction.EditingAndMoveDown]
  /// It switches to the editing state, and moves down in the editing state.
  ///
  /// [PlutoEnterKeyAction.EditingAndMoveRight]
  /// It switches to the editing state, and moves to the right in the editing state.
  ///
  /// [PlutoEnterKeyAction.ToggleEditing]
  /// The editing state is toggled and cells are not moved.
  ///
  /// [PlutoEnterKeyAction.None]
  /// There is no action.
  final PlutoGridEnterKeyAction enterKeyAction;

  /// Tab key action type.
  ///
  /// [PlutoGridTabKeyAction.normal]
  /// {@macro pluto_grid_tab_key_action_normal}
  ///
  /// [PlutoGridTabKeyAction.moveToNextOnEdge]
  /// {@macro pluto_grid_tab_key_action_moveToNextOnEdge}
  final PlutoGridTabKeyAction tabKeyAction;

  /// Set custom shortcut keys.
  ///
  /// Refer to the code below to redefine the action of a specific key
  /// or add a new shortcut action.
  /// The example code below overrides the enter key behavior.
  ///
  /// ```dart
  /// shortcut: PlutoGridShortcut(
  ///   actions: {
  ///     ...PlutoGridShortcut.defaultActions,
  ///     LogicalKeySet(LogicalKeyboardKey.enter): CustomEnterKeyAction(),
  ///   },
  /// ),
  ///
  /// class CustomEnterKeyAction extends PlutoGridShortcutAction {
  ///   @override
  ///   void execute({
  ///     required PlutoKeyManagerEvent keyEvent,
  ///     required PlutoGridStateManager stateManager,
  ///   }) {
  ///     print('Pressed enter key.');
  ///   }
  /// }
  /// ```
  final PlutoGridShortcut shortcut;

  /// Set borders of [PlutoGrid] and columns, cells, and rows.
  final PlutoGridStyleConfig style;

  /// Customise scrollbars for desktop usage
  final PlutoGridScrollbarConfig scrollbar;

  /// Customise filter of columns
  final PlutoGridColumnFilterConfig columnFilter;

  /// Automatically adjust the column width or set the width change condition.
  final PlutoGridColumnSizeConfig columnSize;

  final PlutoGridLocaleText localeText;

  const PlutoGridConfiguration({
    this.enableMoveDownAfterSelecting = false,
    this.enableMoveHorizontalInEditing = false,
    this.enterKeyAction = PlutoGridEnterKeyAction.editingAndMoveDown,
    this.tabKeyAction = PlutoGridTabKeyAction.normal,
    this.shortcut = const PlutoGridShortcut(),
    this.style = const PlutoGridStyleConfig(),
    this.scrollbar = const PlutoGridScrollbarConfig(),
    this.columnFilter = const PlutoGridColumnFilterConfig(),
    this.columnSize = const PlutoGridColumnSizeConfig(),
    this.localeText = const PlutoGridLocaleText.brazilianPortuguese(),
  });

  const PlutoGridConfiguration.dark({
    this.enableMoveDownAfterSelecting = false,
    this.enableMoveHorizontalInEditing = false,
    this.enterKeyAction = PlutoGridEnterKeyAction.editingAndMoveDown,
    this.tabKeyAction = PlutoGridTabKeyAction.normal,
    this.shortcut = const PlutoGridShortcut(),
    this.style = const PlutoGridStyleConfig.dark(),
    this.scrollbar = const PlutoGridScrollbarConfig(),
    this.columnFilter = const PlutoGridColumnFilterConfig(),
    this.columnSize = const PlutoGridColumnSizeConfig(),
    this.localeText = const PlutoGridLocaleText.brazilianPortuguese(),
  });

  void updateLocale() {
    PlutoFilterTypeContains.name = localeText.filterContains;
    PlutoFilterTypeEquals.name = localeText.filterEquals;
    PlutoFilterTypeStartsWith.name = localeText.filterStartsWith;
    PlutoFilterTypeEndsWith.name = localeText.filterEndsWith;
    PlutoFilterTypeGreaterThan.name = localeText.filterGreaterThan;
    PlutoFilterTypeGreaterThanOrEqualTo.name =
        localeText.filterGreaterThanOrEqualTo;
    PlutoFilterTypeLessThan.name = localeText.filterLessThan;
    PlutoFilterTypeLessThanOrEqualTo.name = localeText.filterLessThanOrEqualTo;
  }

  /// Fired when setConfiguration is called in [PlutoGridStateManager]'s constructor.
  void applyColumnFilter(List<PlutoColumn>? refColumns) {
    if (refColumns == null || refColumns.isEmpty) {
      return;
    }

    var len = refColumns.length;

    for (var i = 0; i < len; i += 1) {
      var column = refColumns[i];

      column.setDefaultFilter(
        columnFilter.getDefaultColumnFilter(column),
      );
    }
  }

  PlutoGridConfiguration copyWith({
    bool? enableMoveDownAfterSelecting,
    bool? enableMoveHorizontalInEditing,
    PlutoGridEnterKeyAction? enterKeyAction,
    PlutoGridTabKeyAction? tabKeyAction,
    PlutoGridShortcut? shortcut,
    PlutoGridStyleConfig? style,
    PlutoGridScrollbarConfig? scrollbar,
    PlutoGridColumnFilterConfig? columnFilter,
    PlutoGridColumnSizeConfig? columnSize,
    PlutoGridLocaleText? localeText,
  }) {
    return PlutoGridConfiguration(
      enableMoveDownAfterSelecting:
          enableMoveDownAfterSelecting ?? this.enableMoveDownAfterSelecting,
      enableMoveHorizontalInEditing:
          enableMoveHorizontalInEditing ?? this.enableMoveHorizontalInEditing,
      enterKeyAction: enterKeyAction ?? this.enterKeyAction,
      tabKeyAction: tabKeyAction ?? this.tabKeyAction,
      shortcut: shortcut ?? this.shortcut,
      style: style ?? this.style,
      scrollbar: scrollbar ?? this.scrollbar,
      columnFilter: columnFilter ?? this.columnFilter,
      columnSize: columnSize ?? this.columnSize,
      localeText: localeText ?? this.localeText,
    );
  }

  @override
  bool operator ==(covariant Object other) {
    return identical(this, other) ||
        other is PlutoGridConfiguration &&
            runtimeType == other.runtimeType &&
            enableMoveDownAfterSelecting ==
                other.enableMoveDownAfterSelecting &&
            enableMoveHorizontalInEditing ==
                other.enableMoveHorizontalInEditing &&
            enterKeyAction == other.enterKeyAction &&
            tabKeyAction == other.tabKeyAction &&
            shortcut == other.shortcut &&
            style == other.style &&
            scrollbar == other.scrollbar &&
            columnFilter == other.columnFilter &&
            columnSize == other.columnSize &&
            localeText == other.localeText;
  }

  @override
  int get hashCode => Object.hash(
        enableMoveDownAfterSelecting,
        enableMoveHorizontalInEditing,
        enterKeyAction,
        tabKeyAction,
        shortcut,
        style,
        scrollbar,
        columnFilter,
        columnSize,
        localeText,
      );
}

class PlutoGridStyleConfig {
  const PlutoGridStyleConfig({
    this.enableGridBorderShadow = false,
    this.enableColumnBorderVertical = true,
    this.enableColumnBorderHorizontal = true,
    this.enableCellBorderVertical = true,
    this.enableCellBorderHorizontal = true,
    this.enableRowColorAnimation = false,
    this.gridBackgroundColor = Colors.white,
    this.rowColor = Colors.white,
    this.oddRowColor,
    this.evenRowColor,
    this.activatedColor = const Color(0xFFDCF5FF),
    this.checkedColor = const Color(0x11757575),
    this.cellColorInEditState = Colors.white,
    this.cellColorInReadOnlyState = const Color(0xFFDBDBDC),
    this.cellColorGroupedRow,
    this.dragTargetColumnColor = const Color(0xFFDCF5FF),
    this.iconColor = Colors.black26,
    this.disabledIconColor = Colors.black12,
    this.menuBackgroundColor = Colors.white,
    this.gridBorderColor = const Color(0xFFA1A5AE),
    this.borderColor = const Color(0xFFDDE2EB),
    this.activatedBorderColor = Colors.lightBlue,
    this.inactivatedBorderColor = const Color(0xFFC4C7CC),
    this.iconSize = 18,
    this.rowHeight = PlutoGridSettings.rowHeight,
    this.columnHeight = PlutoGridSettings.rowHeight,
    this.columnFilterHeight = PlutoGridSettings.rowHeight,
    this.defaultColumnTitlePadding = PlutoGridSettings.columnTitlePadding,
    this.defaultColumnFilterPadding = PlutoGridSettings.columnFilterPadding,
    this.defaultCellPadding = PlutoGridSettings.cellPadding,
    this.columnTextStyle = const TextStyle(
      color: Colors.black,
      decoration: TextDecoration.none,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    this.cellTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 14,
    ),
    this.columnContextIcon = Icons.dehaze,
    this.columnResizeIcon = Icons.code_sharp,
    this.columnAscendingIcon,
    this.columnDescendingIcon,
    this.rowGroupExpandedIcon = Icons.keyboard_arrow_down,
    this.rowGroupCollapsedIcon = const IconData(
      0xe355,
      matchTextDirection: true,
      fontFamily: 'MaterialIcons',
    ),
    this.rowGroupEmptyIcon = Icons.noise_control_off,
    this.gridBorderRadius = BorderRadius.zero,
    this.gridPopupBorderRadius = BorderRadius.zero,
  });

  const PlutoGridStyleConfig.dark({
    this.enableGridBorderShadow = false,
    this.enableColumnBorderVertical = true,
    this.enableColumnBorderHorizontal = true,
    this.enableCellBorderVertical = true,
    this.enableCellBorderHorizontal = true,
    this.enableRowColorAnimation = false,
    this.gridBackgroundColor = const Color(0xFF111111),
    this.rowColor = const Color(0xFF111111),
    this.oddRowColor,
    this.evenRowColor,
    this.activatedColor = const Color(0xFF313131),
    this.checkedColor = const Color(0x11202020),
    this.cellColorInEditState = const Color(0xFF666666),
    this.cellColorInReadOnlyState = const Color(0xFF222222),
    this.cellColorGroupedRow,
    this.dragTargetColumnColor = const Color(0xFF313131),
    this.iconColor = Colors.white38,
    this.disabledIconColor = Colors.white12,
    this.menuBackgroundColor = const Color(0xFF414141),
    this.gridBorderColor = const Color(0xFF666666),
    this.borderColor = const Color(0xFF222222),
    this.activatedBorderColor = const Color(0xFFFFFFFF),
    this.inactivatedBorderColor = const Color(0xFF666666),
    this.iconSize = 18,
    this.rowHeight = PlutoGridSettings.rowHeight,
    this.columnHeight = PlutoGridSettings.rowHeight,
    this.columnFilterHeight = PlutoGridSettings.rowHeight,
    this.defaultColumnTitlePadding = PlutoGridSettings.columnTitlePadding,
    this.defaultColumnFilterPadding = PlutoGridSettings.columnFilterPadding,
    this.defaultCellPadding = PlutoGridSettings.cellPadding,
    this.columnTextStyle = const TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    this.cellTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
    this.columnContextIcon = Icons.dehaze,
    this.columnResizeIcon = Icons.code_sharp,
    this.columnAscendingIcon,
    this.columnDescendingIcon,
    this.rowGroupExpandedIcon = Icons.keyboard_arrow_down,
    this.rowGroupCollapsedIcon = const IconData(
      0xe355,
      matchTextDirection: true,
      fontFamily: 'MaterialIcons',
    ),
    this.rowGroupEmptyIcon = Icons.noise_control_off,
    this.gridBorderRadius = BorderRadius.zero,
    this.gridPopupBorderRadius = BorderRadius.zero,
  });

  /// Enable borderShadow in [PlutoGrid].
  final bool enableGridBorderShadow;

  /// Enable the vertical border of [PlutoColumn] and [PlutoColumnGroup].
  final bool enableColumnBorderVertical;

  /// Enable the horizontal border of [PlutoColumn] and [PlutoColumnGroup].
  final bool enableColumnBorderHorizontal;

  /// Enable the vertical border of [PlutoCell].
  final bool enableCellBorderVertical;

  /// Enable the horizontal border of [PlutoCell].
  final bool enableCellBorderHorizontal;

  /// Animation of background color transition of rows,
  /// such as when the current row or rows are dragged.
  final bool enableRowColorAnimation;

  final Color gridBackgroundColor;

  /// Default row background color
  ///
  /// If [PlutoGrid.rowColorCallback] is set, rowColorCallback takes precedence.
  final Color rowColor;

  /// Background color for odd rows
  ///
  /// The first row, which is number 0, is treated as an odd row.
  /// If [PlutoGrid.rowColorCallback] is set, rowColorCallback takes precedence.
  final Color? oddRowColor;

  /// Background color for even rows
  ///
  /// The row with number 1 is treated as an even row.
  /// If [PlutoGrid.rowColorCallback] is set, rowColorCallback takes precedence.
  final Color? evenRowColor;

  /// Activated Color. (Current or Selected row, cell)
  final Color activatedColor;

  /// Checked Color. (Checked rows)
  final Color checkedColor;

  /// Cell color in edit state. (only current cell)
  final Color cellColorInEditState;

  /// Cell color in read-only state
  final Color cellColorInReadOnlyState;

  /// Background color of cells grouped by column.
  final Color? cellColorGroupedRow;

  /// The background color of the column to be dragged.
  /// When moving a column by dragging it.
  final Color dragTargetColumnColor;

  /// Icon color. (column menu, cell of popup type, pagination plugin)
  final Color iconColor;

  /// Disabled icon color. (pagination plugin)
  final Color disabledIconColor;

  /// BackgroundColor of Popup menu. (column menu)
  final Color menuBackgroundColor;

  /// Set the border color of [PlutoGrid].
  final Color gridBorderColor;

  /// Set the border color of the widgets inside [PlutoGrid].
  ///
  /// Border color is set
  /// for [PlutoColumn], [PlutoColumnGroup], [PlutoCell], [PlutoRow], etc.
  final Color borderColor;

  /// Border color set when widgets such as [PlutoRow] and [PlutoCell]
  /// receive focus or are currently selected.
  final Color activatedBorderColor;

  /// Border color set when widgets such as [PlutoRow] and [PlutoCell] lose focus.
  final Color inactivatedBorderColor;

  /// Icon size. (column menu, cell of popup type)
  final double iconSize;

  /// Height of a row.
  final double rowHeight;

  /// Height of column.
  final double columnHeight;

  /// Height of column filter.
  final double columnFilterHeight;

  /// Customise column title padding
  /// If there is no titlePadding of PlutoColumn,
  /// it is the title padding of the default column.
  final EdgeInsets defaultColumnTitlePadding;

  final EdgeInsets defaultColumnFilterPadding;

  /// Customise cell padding
  /// If there is no cellPadding of PlutoColumn,
  /// it is the padding value of cell.
  final EdgeInsets defaultCellPadding;

  /// Column - text style
  final TextStyle columnTextStyle;

  /// Cell - text style
  final TextStyle cellTextStyle;

  /// Icon that can open a pop-up menu next to the column title
  /// when [enableContextMenu] of [PlutoColumn] is true.
  final IconData columnContextIcon;

  /// If enableContextMenu of PlutoColumn is false and enableDropToResize is true,
  /// only the width of the column can be adjusted.
  final IconData columnResizeIcon;

  /// Ascending icon when sorting a column.
  ///
  /// If no value is specified, the default icon is set.
  final Icon? columnAscendingIcon;

  /// Descending icon when sorting a column.
  ///
  /// If no value is specified, the default icon is set.
  final Icon? columnDescendingIcon;

  /// Icon when RowGroup is expanded.
  final IconData rowGroupExpandedIcon;

  /// Icon when RowGroup is collapsed.
  final IconData rowGroupCollapsedIcon;

  /// Icon when RowGroup is empty.
  final IconData rowGroupEmptyIcon;

  /// Apply the border radius of [PlutoGrid].
  final BorderRadiusGeometry gridBorderRadius;

  /// Apply border radius to popup opened inside [PlutoGrid].
  final BorderRadiusGeometry gridPopupBorderRadius;

  PlutoGridStyleConfig copyWith({
    bool? enableGridBorderShadow,
    bool? enableColumnBorderVertical,
    bool? enableColumnBorderHorizontal,
    bool? enableCellBorderVertical,
    bool? enableCellBorderHorizontal,
    bool? enableRowColorAnimation,
    Color? gridBackgroundColor,
    Color? rowColor,
    PlutoOptional<Color?>? oddRowColor,
    PlutoOptional<Color?>? evenRowColor,
    Color? activatedColor,
    Color? checkedColor,
    Color? cellColorInEditState,
    Color? cellColorInReadOnlyState,
    PlutoOptional<Color?>? cellColorGroupedRow,
    Color? dragTargetColumnColor,
    Color? iconColor,
    Color? disabledIconColor,
    Color? menuBackgroundColor,
    Color? gridBorderColor,
    Color? borderColor,
    Color? activatedBorderColor,
    Color? inactivatedBorderColor,
    double? iconSize,
    double? rowHeight,
    double? columnHeight,
    double? columnFilterHeight,
    EdgeInsets? defaultColumnTitlePadding,
    EdgeInsets? defaultColumnFilterPadding,
    EdgeInsets? defaultCellPadding,
    TextStyle? columnTextStyle,
    TextStyle? cellTextStyle,
    IconData? columnContextIcon,
    IconData? columnResizeIcon,
    PlutoOptional<Icon?>? columnAscendingIcon,
    PlutoOptional<Icon?>? columnDescendingIcon,
    IconData? rowGroupExpandedIcon,
    IconData? rowGroupCollapsedIcon,
    IconData? rowGroupEmptyIcon,
    BorderRadiusGeometry? gridBorderRadius,
    BorderRadiusGeometry? gridPopupBorderRadius,
  }) {
    return PlutoGridStyleConfig(
      enableGridBorderShadow:
          enableGridBorderShadow ?? this.enableGridBorderShadow,
      enableColumnBorderVertical:
          enableColumnBorderVertical ?? this.enableColumnBorderVertical,
      enableColumnBorderHorizontal:
          enableColumnBorderHorizontal ?? this.enableColumnBorderHorizontal,
      enableCellBorderVertical:
          enableCellBorderVertical ?? this.enableCellBorderVertical,
      enableCellBorderHorizontal:
          enableCellBorderHorizontal ?? this.enableCellBorderHorizontal,
      enableRowColorAnimation:
          enableRowColorAnimation ?? this.enableRowColorAnimation,
      gridBackgroundColor: gridBackgroundColor ?? this.gridBackgroundColor,
      rowColor: rowColor ?? this.rowColor,
      oddRowColor: oddRowColor == null ? this.oddRowColor : oddRowColor.value,
      evenRowColor:
          evenRowColor == null ? this.evenRowColor : evenRowColor.value,
      activatedColor: activatedColor ?? this.activatedColor,
      checkedColor: checkedColor ?? this.checkedColor,
      cellColorInEditState: cellColorInEditState ?? this.cellColorInEditState,
      cellColorInReadOnlyState:
          cellColorInReadOnlyState ?? this.cellColorInReadOnlyState,
      cellColorGroupedRow: cellColorGroupedRow == null
          ? this.cellColorGroupedRow
          : cellColorGroupedRow.value,
      dragTargetColumnColor:
          dragTargetColumnColor ?? this.dragTargetColumnColor,
      iconColor: iconColor ?? this.iconColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor,
      menuBackgroundColor: menuBackgroundColor ?? this.menuBackgroundColor,
      gridBorderColor: gridBorderColor ?? this.gridBorderColor,
      borderColor: borderColor ?? this.borderColor,
      activatedBorderColor: activatedBorderColor ?? this.activatedBorderColor,
      inactivatedBorderColor:
          inactivatedBorderColor ?? this.inactivatedBorderColor,
      iconSize: iconSize ?? this.iconSize,
      rowHeight: rowHeight ?? this.rowHeight,
      columnHeight: columnHeight ?? this.columnHeight,
      columnFilterHeight: columnFilterHeight ?? this.columnFilterHeight,
      defaultColumnTitlePadding:
          defaultColumnTitlePadding ?? this.defaultColumnTitlePadding,
      defaultColumnFilterPadding:
          defaultColumnFilterPadding ?? this.defaultColumnFilterPadding,
      defaultCellPadding: defaultCellPadding ?? this.defaultCellPadding,
      columnTextStyle: columnTextStyle ?? this.columnTextStyle,
      cellTextStyle: cellTextStyle ?? this.cellTextStyle,
      columnContextIcon: columnContextIcon ?? this.columnContextIcon,
      columnResizeIcon: columnResizeIcon ?? this.columnResizeIcon,
      columnAscendingIcon: columnAscendingIcon == null
          ? this.columnAscendingIcon
          : columnAscendingIcon.value,
      columnDescendingIcon: columnDescendingIcon == null
          ? this.columnDescendingIcon
          : columnDescendingIcon.value,
      rowGroupExpandedIcon: rowGroupExpandedIcon ?? this.rowGroupExpandedIcon,
      rowGroupCollapsedIcon:
          rowGroupCollapsedIcon ?? this.rowGroupCollapsedIcon,
      rowGroupEmptyIcon: rowGroupEmptyIcon ?? this.rowGroupEmptyIcon,
      gridBorderRadius: gridBorderRadius ?? this.gridBorderRadius,
      gridPopupBorderRadius:
          gridPopupBorderRadius ?? this.gridPopupBorderRadius,
    );
  }

  @override
  bool operator ==(covariant Object other) {
    return identical(this, other) ||
        other is PlutoGridStyleConfig &&
            runtimeType == other.runtimeType &&
            enableGridBorderShadow == other.enableGridBorderShadow &&
            enableColumnBorderVertical == other.enableColumnBorderVertical &&
            enableColumnBorderHorizontal ==
                other.enableColumnBorderHorizontal &&
            enableCellBorderVertical == other.enableCellBorderVertical &&
            enableCellBorderHorizontal == other.enableCellBorderHorizontal &&
            enableRowColorAnimation == other.enableRowColorAnimation &&
            gridBackgroundColor == other.gridBackgroundColor &&
            rowColor == other.rowColor &&
            oddRowColor == other.oddRowColor &&
            evenRowColor == other.evenRowColor &&
            activatedColor == other.activatedColor &&
            checkedColor == other.checkedColor &&
            cellColorInEditState == other.cellColorInEditState &&
            cellColorInReadOnlyState == other.cellColorInReadOnlyState &&
            cellColorGroupedRow == other.cellColorGroupedRow &&
            dragTargetColumnColor == other.dragTargetColumnColor &&
            iconColor == other.iconColor &&
            disabledIconColor == other.disabledIconColor &&
            menuBackgroundColor == other.menuBackgroundColor &&
            gridBorderColor == other.gridBorderColor &&
            borderColor == other.borderColor &&
            activatedBorderColor == other.activatedBorderColor &&
            inactivatedBorderColor == other.inactivatedBorderColor &&
            iconSize == other.iconSize &&
            rowHeight == other.rowHeight &&
            columnHeight == other.columnHeight &&
            columnFilterHeight == other.columnFilterHeight &&
            defaultColumnTitlePadding == other.defaultColumnTitlePadding &&
            defaultColumnFilterPadding == other.defaultColumnFilterPadding &&
            defaultCellPadding == other.defaultCellPadding &&
            columnTextStyle == other.columnTextStyle &&
            cellTextStyle == other.cellTextStyle &&
            columnContextIcon == other.columnContextIcon &&
            columnResizeIcon == other.columnResizeIcon &&
            columnAscendingIcon == other.columnAscendingIcon &&
            columnDescendingIcon == other.columnDescendingIcon &&
            rowGroupExpandedIcon == other.rowGroupExpandedIcon &&
            rowGroupCollapsedIcon == other.rowGroupCollapsedIcon &&
            rowGroupEmptyIcon == other.rowGroupEmptyIcon &&
            gridBorderRadius == other.gridBorderRadius &&
            gridPopupBorderRadius == other.gridPopupBorderRadius;
  }

  @override
  int get hashCode => Object.hashAll([
        enableGridBorderShadow,
        enableColumnBorderVertical,
        enableColumnBorderHorizontal,
        enableCellBorderVertical,
        enableCellBorderHorizontal,
        enableRowColorAnimation,
        gridBackgroundColor,
        rowColor,
        oddRowColor,
        evenRowColor,
        activatedColor,
        checkedColor,
        cellColorInEditState,
        cellColorInReadOnlyState,
        cellColorGroupedRow,
        dragTargetColumnColor,
        iconColor,
        disabledIconColor,
        menuBackgroundColor,
        gridBorderColor,
        borderColor,
        activatedBorderColor,
        inactivatedBorderColor,
        iconSize,
        rowHeight,
        columnHeight,
        columnFilterHeight,
        defaultColumnTitlePadding,
        defaultColumnFilterPadding,
        defaultCellPadding,
        columnTextStyle,
        cellTextStyle,
        columnContextIcon,
        columnResizeIcon,
        columnAscendingIcon,
        columnDescendingIcon,
        rowGroupExpandedIcon,
        rowGroupCollapsedIcon,
        rowGroupEmptyIcon,
        gridBorderRadius,
        gridPopupBorderRadius,
      ]);
}

/// Allows to customise scrollbars "look and feel"
/// The general feature is making vertical scrollbar draggable and therefore more useful
/// for desktop systems. Set [draggableScrollbar] to true to achieve this behavior. Also
/// changing [isAlwaysShown] to true is recommended for more usability at desktops.
class PlutoGridScrollbarConfig {
  const PlutoGridScrollbarConfig({
    this.draggableScrollbar = true,
    this.isAlwaysShown = false,
    this.onlyDraggingThumb = true,
    this.enableScrollAfterDragEnd = true,
    this.scrollbarThickness = PlutoScrollbar.defaultThickness,
    this.scrollbarThicknessWhileDragging =
        PlutoScrollbar.defaultThicknessWhileDragging,
    this.hoverWidth = PlutoScrollbar.defaultScrollbarHoverWidth,
    this.mainAxisMargin,
    this.crossAxisMargin,
    this.scrollBarColor,
    this.scrollBarTrackColor,
    this.scrollbarRadius = PlutoScrollbar.defaultRadius,
    this.scrollbarRadiusWhileDragging =
        PlutoScrollbar.defaultRadiusWhileDragging,
    this.longPressDuration,
    this.dragDevices,
  });

  final bool draggableScrollbar;

  final bool isAlwaysShown;

  /// If [onlyDraggingThumb] is false, scrolling can be done by dragging the track area.
  final bool onlyDraggingThumb;

  /// If you release the scroll bar after scrolling,
  /// the scroll bar moves further according to the moving speed.
  ///
  /// If set to false,
  /// the scroll bar will stop moving as soon as the scroll bar is released.
  final bool enableScrollAfterDragEnd;

  final double scrollbarThickness;

  final double scrollbarThicknessWhileDragging;

  final double hoverWidth;

  final double? mainAxisMargin;

  final double? crossAxisMargin;

  /// ScrollBar Color
  final Color? scrollBarColor;

  /// ScrollBar Track Color
  final Color? scrollBarTrackColor;

  final Radius scrollbarRadius;

  final Radius scrollbarRadiusWhileDragging;

  /// Set the long press time of the scroll bar. 100 ms if not set.
  final Duration? longPressDuration;

  final Set<PointerDeviceKind>? dragDevices;

  @override
  bool operator ==(covariant Object other) {
    return identical(this, other) ||
        other is PlutoGridScrollbarConfig &&
            runtimeType == other.runtimeType &&
            draggableScrollbar == other.draggableScrollbar &&
            isAlwaysShown == other.isAlwaysShown &&
            onlyDraggingThumb == other.onlyDraggingThumb &&
            enableScrollAfterDragEnd == other.enableScrollAfterDragEnd &&
            scrollbarThickness == other.scrollbarThickness &&
            scrollbarThicknessWhileDragging ==
                other.scrollbarThicknessWhileDragging &&
            hoverWidth == other.hoverWidth &&
            mainAxisMargin == other.mainAxisMargin &&
            crossAxisMargin == other.crossAxisMargin &&
            scrollBarColor == other.scrollBarColor &&
            scrollBarTrackColor == other.scrollBarTrackColor &&
            scrollbarRadius == other.scrollbarRadius &&
            scrollbarRadiusWhileDragging ==
                other.scrollbarRadiusWhileDragging &&
            longPressDuration == other.longPressDuration &&
            dragDevices == other.dragDevices;
  }

  @override
  int get hashCode => Object.hash(
        draggableScrollbar,
        isAlwaysShown,
        onlyDraggingThumb,
        enableScrollAfterDragEnd,
        scrollbarThickness,
        scrollbarThicknessWhileDragging,
        hoverWidth,
        mainAxisMargin,
        crossAxisMargin,
        scrollBarColor,
        scrollBarTrackColor,
        scrollbarRadius,
        scrollbarRadiusWhileDragging,
        longPressDuration,
        dragDevices,
      );
}

typedef PlutoGridColumnFilterResolver = Function<T>();

typedef PlutoGridResolveDefaultColumnFilter = PlutoFilterType Function(
  PlutoColumn column,
  PlutoGridColumnFilterResolver resolver,
);

class PlutoGridColumnFilterConfig {
  /// # Set the filter information of the column.
  ///
  /// **Return the value returned by [resolveDefaultColumnFilter] through the resolver function.**
  /// **Prevents errors returning filter that are not in the [filters] list.**
  ///
  /// The value of returning from resolveDefaultColumnFilter
  /// becomes the condition of TextField below the column or
  /// is set as the default filter when calling the column popup.
  ///
  /// ```dart
  ///
  /// var filterConfig = PlutoColumnFilterConfig(
  ///   filters: const [
  ///     ...FilterHelper.defaultFilters,
  ///     // custom filter
  ///     ClassYouImplemented(),
  ///   ],
  ///   resolveDefaultColumnFilter: (column, resolver) {
  ///     if (column.field == 'text') {
  ///       return resolver<PlutoFilterTypeContains>();
  ///     } else if (column.field == 'number') {
  ///       return resolver<PlutoFilterTypeGreaterThan>();
  ///     } else if (column.field == 'date') {
  ///       return resolver<PlutoFilterTypeLessThan>();
  ///     } else if (column.field == 'select') {
  ///       return resolver<ClassYouImplemented>();
  ///     }
  ///
  ///     return resolver<PlutoFilterTypeContains>();
  ///   },
  /// );
  ///
  /// class ClassYouImplemented implements PlutoFilterType {
  ///   String get title => 'Custom contains';
  ///
  ///   get compare => ({
  ///         String base,
  ///         String search,
  ///         PlutoColumn column,
  ///       }) {
  ///         var keys = search.split(',').map((e) => e.toUpperCase()).toList();
  ///
  ///         return keys.contains(base.toUpperCase());
  ///       };
  ///
  ///   const ClassYouImplemented();
  /// }
  /// ```
  const PlutoGridColumnFilterConfig({
    List<PlutoFilterType>? filters,
    PlutoGridResolveDefaultColumnFilter? resolveDefaultColumnFilter,
    int? debounceMilliseconds,
  })  : _userFilters = filters,
        _userResolveDefaultColumnFilter = resolveDefaultColumnFilter,
        _debounceMilliseconds = debounceMilliseconds == null
            ? PlutoGridSettings.debounceMillisecondsForColumnFilter
            : debounceMilliseconds < 0
                ? 0
                : debounceMilliseconds;

  final List<PlutoFilterType>? _userFilters;

  final PlutoGridResolveDefaultColumnFilter? _userResolveDefaultColumnFilter;

  final int _debounceMilliseconds;

  bool get hasUserFilter => _userFilters != null && _userFilters!.isNotEmpty;

  List<PlutoFilterType> get filters =>
      hasUserFilter ? _userFilters! : FilterHelper.defaultFilters;

  int get debounceMilliseconds => _debounceMilliseconds;

  PlutoFilterType resolver<T>() {
    return filters.firstWhereOrNull(
          (element) => element.runtimeType == T,
        ) ??
        filters.first;
  }

  PlutoFilterType getDefaultColumnFilter(PlutoColumn column) {
    if (_userResolveDefaultColumnFilter == null) {
      return filters.first;
    }

    var resolvedFilter = _userResolveDefaultColumnFilter!(column, resolver);

    assert(filters.contains(resolvedFilter));

    return resolvedFilter;
  }

  @override
  bool operator ==(covariant Object other) {
    return identical(this, other) ||
        other is PlutoGridColumnFilterConfig &&
            runtimeType == other.runtimeType &&
            listEquals(_userFilters, other._userFilters) &&
            _userResolveDefaultColumnFilter ==
                other._userResolveDefaultColumnFilter &&
            _debounceMilliseconds == other._debounceMilliseconds;
  }

  @override
  int get hashCode => Object.hash(
        _userFilters,
        _userResolveDefaultColumnFilter,
        _debounceMilliseconds,
      );
}

/// Automatically change the column width or set the mode when changing the width.
class PlutoGridColumnSizeConfig {
  const PlutoGridColumnSizeConfig({
    this.autoSizeMode = PlutoAutoSizeMode.none,
    this.resizeMode = PlutoResizeMode.normal,
    this.restoreAutoSizeAfterHideColumn = true,
    this.restoreAutoSizeAfterFrozenColumn = true,
    this.restoreAutoSizeAfterMoveColumn = true,
    this.restoreAutoSizeAfterInsertColumn = true,
    this.restoreAutoSizeAfterRemoveColumn = true,
  });

  /// Automatically change the column width.
  final PlutoAutoSizeMode autoSizeMode;

  /// This is the condition for changing the width of the column.
  final PlutoResizeMode resizeMode;

  /// [PlutoColumn.hide] Whether to apply autoSizeMode after state change.
  /// If false, autoSizeMode is not applied after the state change
  /// and the state after the change is maintained.
  final bool restoreAutoSizeAfterHideColumn;

  /// [PlutoColumn.frozen] Whether to apply autoSizeMode after state change.
  /// If false, autoSizeMode is not applied after the state change
  /// and the state after the change is maintained.
  final bool restoreAutoSizeAfterFrozenColumn;

  /// Whether to apply autoSizeMode after [PlutoColumn] is moved.
  /// If false, do not apply autoSizeMode after moving
  /// and keep the state after change.
  final bool restoreAutoSizeAfterMoveColumn;

  /// Whether to apply autoSizeMode after adding [PlutoColumn].
  /// If false, autoSizeMode is not applied after column addition
  /// and the state after change is maintained.
  final bool restoreAutoSizeAfterInsertColumn;

  /// [PlutoColumn] Whether to apply autoSizeMode after deletion.
  /// If false, autoSizeMode is not applied after deletion
  /// and the state after change is maintained.
  final bool restoreAutoSizeAfterRemoveColumn;

  PlutoGridColumnSizeConfig copyWith({
    PlutoAutoSizeMode? autoSizeMode,
    PlutoResizeMode? resizeMode,
    bool? restoreAutoSizeAfterHideColumn,
    bool? restoreAutoSizeAfterFrozenColumn,
    bool? restoreAutoSizeAfterMoveColumn,
    bool? restoreAutoSizeAfterInsertColumn,
    bool? restoreAutoSizeAfterRemoveColumn,
  }) {
    return PlutoGridColumnSizeConfig(
      autoSizeMode: autoSizeMode ?? this.autoSizeMode,
      resizeMode: resizeMode ?? this.resizeMode,
      restoreAutoSizeAfterHideColumn:
          restoreAutoSizeAfterHideColumn ?? this.restoreAutoSizeAfterHideColumn,
      restoreAutoSizeAfterFrozenColumn: restoreAutoSizeAfterFrozenColumn ??
          this.restoreAutoSizeAfterFrozenColumn,
      restoreAutoSizeAfterMoveColumn:
          restoreAutoSizeAfterMoveColumn ?? this.restoreAutoSizeAfterMoveColumn,
      restoreAutoSizeAfterInsertColumn: restoreAutoSizeAfterInsertColumn ??
          this.restoreAutoSizeAfterInsertColumn,
      restoreAutoSizeAfterRemoveColumn: restoreAutoSizeAfterRemoveColumn ??
          this.restoreAutoSizeAfterRemoveColumn,
    );
  }

  @override
  bool operator ==(covariant Object other) {
    return identical(this, other) ||
        other is PlutoGridColumnSizeConfig &&
            runtimeType == other.runtimeType &&
            autoSizeMode == other.autoSizeMode &&
            resizeMode == other.resizeMode &&
            restoreAutoSizeAfterHideColumn ==
                other.restoreAutoSizeAfterHideColumn &&
            restoreAutoSizeAfterFrozenColumn ==
                other.restoreAutoSizeAfterFrozenColumn &&
            restoreAutoSizeAfterMoveColumn ==
                other.restoreAutoSizeAfterMoveColumn &&
            restoreAutoSizeAfterInsertColumn ==
                other.restoreAutoSizeAfterInsertColumn &&
            restoreAutoSizeAfterRemoveColumn ==
                other.restoreAutoSizeAfterRemoveColumn;
  }

  @override
  int get hashCode => Object.hash(
        autoSizeMode,
        resizeMode,
        restoreAutoSizeAfterHideColumn,
        restoreAutoSizeAfterFrozenColumn,
        restoreAutoSizeAfterMoveColumn,
        restoreAutoSizeAfterInsertColumn,
        restoreAutoSizeAfterRemoveColumn,
      );
}

class PlutoGridLocaleText {
  // Column menu
  final String unfreezeColumn;
  final String freezeColumnToStart;
  final String freezeColumnToEnd;
  final String autoFitColumn;
  final String hideColumn;
  final String setColumns;
  final String setFilter;
  final String resetFilter;

  // SetColumns popup
  final String setColumnsTitle;

  // Filter popup
  final String filterColumn;
  final String filterType;
  final String filterValue;
  final String filterAllColumns;
  final String filterContains;
  final String filterEquals;
  final String filterStartsWith;
  final String filterEndsWith;
  final String filterGreaterThan;
  final String filterGreaterThanOrEqualTo;
  final String filterLessThan;
  final String filterLessThanOrEqualTo;

  // Date column popup
  final String sunday;
  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;

  // Time column popup
  final String hour;
  final String minute;

  // Common
  final String loadingText;

  const PlutoGridLocaleText.brazilianPortuguese({
    // Column menu
    this.unfreezeColumn = 'Destravar',
    this.freezeColumnToStart = 'Travar no início',
    this.freezeColumnToEnd = 'Trava no final',
    this.autoFitColumn = 'Auto Ajustar',
    this.hideColumn = 'Esconder coluna',
    this.setColumns = 'Definir colunas',
    this.setFilter = 'Definir fitros',
    this.resetFilter = 'Limpar filtros',
    this.setColumnsTitle = 'Título da coluna',
    this.filterColumn = 'Coluna',
    this.filterType = 'Tipo',
    this.filterValue = 'Valor',
    this.filterAllColumns = 'Todas as colunas',
    this.filterContains = 'Contenha',
    this.filterEquals = 'Igual',
    this.filterStartsWith = 'Inicia com',
    this.filterEndsWith = 'Termina com',
    this.filterGreaterThan = 'Maior que',
    this.filterGreaterThanOrEqualTo = 'Maior ou igual que',
    this.filterLessThan = 'Menor que',
    this.filterLessThanOrEqualTo = 'Menor ou igual que',
    this.sunday = 'Dom',
    this.monday = 'Seg',
    this.tuesday = 'Ter',
    this.wednesday = 'Qua',
    this.thursday = 'Qui',
    this.friday = 'Sex',
    this.saturday = 'Sab',
    this.hour = 'Hora',
    this.minute = 'Minuto',
    this.loadingText = 'Carregando',
  });

  @override
  bool operator ==(covariant Object other) {
    return identical(this, other) ||
        other is PlutoGridLocaleText &&
            runtimeType == other.runtimeType &&
            unfreezeColumn == other.unfreezeColumn &&
            freezeColumnToStart == other.freezeColumnToStart &&
            freezeColumnToEnd == other.freezeColumnToEnd &&
            autoFitColumn == other.autoFitColumn &&
            hideColumn == other.hideColumn &&
            setColumns == other.setColumns &&
            setFilter == other.setFilter &&
            resetFilter == other.resetFilter &&
            setColumnsTitle == other.setColumnsTitle &&
            filterColumn == other.filterColumn &&
            filterType == other.filterType &&
            filterValue == other.filterValue &&
            filterAllColumns == other.filterAllColumns &&
            filterContains == other.filterContains &&
            filterEquals == other.filterEquals &&
            filterStartsWith == other.filterStartsWith &&
            filterEndsWith == other.filterEndsWith &&
            filterGreaterThan == other.filterGreaterThan &&
            filterGreaterThanOrEqualTo == other.filterGreaterThanOrEqualTo &&
            filterLessThan == other.filterLessThan &&
            filterLessThanOrEqualTo == other.filterLessThanOrEqualTo &&
            sunday == other.sunday &&
            monday == other.monday &&
            tuesday == other.tuesday &&
            wednesday == other.wednesday &&
            thursday == other.thursday &&
            friday == other.friday &&
            saturday == other.saturday &&
            hour == other.hour &&
            minute == other.minute &&
            loadingText == other.loadingText;
  }

  @override
  int get hashCode => Object.hashAll([
        unfreezeColumn,
        freezeColumnToStart,
        freezeColumnToEnd,
        autoFitColumn,
        hideColumn,
        setColumns,
        setFilter,
        resetFilter,
        setColumnsTitle,
        filterColumn,
        filterType,
        filterValue,
        filterAllColumns,
        filterContains,
        filterEquals,
        filterStartsWith,
        filterEndsWith,
        filterGreaterThan,
        filterGreaterThanOrEqualTo,
        filterLessThan,
        filterLessThanOrEqualTo,
        sunday,
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday,
        hour,
        minute,
        loadingText,
      ]);
}

/// Behavior of the Enter key when a cell is selected.
enum PlutoGridEnterKeyAction {
  /// When the Enter key is pressed, the cell is changed to the edit state,
  /// or if it is already in the edit state, it moves to the cell below.
  editingAndMoveDown,

  /// When the Enter key is pressed, the cell is changed to the edit state,
  /// or if it is already in the edit state, it moves to the right cell.
  editingAndMoveRight,

  /// Pressing the Enter key toggles the editing status.
  toggleEditing,

  /// Pressing the Enter key does nothing.
  none;

  bool get isEditingAndMoveDown =>
      this == PlutoGridEnterKeyAction.editingAndMoveDown;

  bool get isEditingAndMoveRight =>
      this == PlutoGridEnterKeyAction.editingAndMoveRight;

  bool get isToggleEditing => this == PlutoGridEnterKeyAction.toggleEditing;

  bool get isNone => this == PlutoGridEnterKeyAction.none;
}

/// Tab key action type.
enum PlutoGridTabKeyAction {
  /// {@template pluto_grid_tab_key_action_normal}
  /// Tab or Shift Tab key moves when reaching the edge no longer moves.
  /// {@endtemplate}
  normal,

  /// {@template pluto_grid_tab_key_action_moveToNextOnEdge}
  /// Tab or Shift Tab key to continue moving to the next or previous row
  /// of cells when the edge is reached.
  /// {@endtemplate}
  moveToNextOnEdge;

  bool get isNormal => this == PlutoGridTabKeyAction.normal;

  bool get isMoveToNextOnEdge => this == PlutoGridTabKeyAction.moveToNextOnEdge;
}
