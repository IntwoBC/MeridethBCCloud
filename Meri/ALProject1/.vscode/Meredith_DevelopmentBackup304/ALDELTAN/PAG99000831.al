pageextension 50036 pageextension70000919 extends "Released Production Order"
{
    actions
    {
        addafter("O&rder")
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(ProductionJournal)
                {
                    ApplicationArea = All;
                    Caption = '&Production Journal';
                    Image = Journal;

                    trigger OnAction()
                    begin
                        //CurrPage.ProdOrderLines.PAGE.ShowProductionJournal;
                    end;
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        ApplicationArea = All;
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            //CurrPage.ProdOrderLines.PAGE.ItemAvailability(ItemAvailFormsMgt.ByEvent);
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';
                        Image = Period;

                        trigger OnAction()
                        begin
                            //CurrPage.ProdOrderLines.PAGE.ItemAvailability(ItemAvailFormsMgt.ByPeriod);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';
                        Image = ItemVariant;

                        trigger OnAction()
                        begin
                            //CurrPage.ProdOrderLines.PAGE.ItemAvailability(ItemAvailFormsMgt.ByVariant);
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            //CurrPage.ProdOrderLines.PAGE.ItemAvailability(ItemAvailFormsMgt.ByLocation);
                        end;
                    }
                    action("BOM Level")
                    {
                        ApplicationArea = All;
                        Caption = 'BOM Level';
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            //CurrPage.ProdOrderLines.PAGE.ItemAvailability(ItemAvailFormsMgt.ByBOM);
                        end;
                    }
                }
                separator(Separator91)
                {
                }
                action("Reservation Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;

                    trigger OnAction()
                    begin
                        //CurrPage.ProdOrderLines.PAGE.ShowReservationEntries;
                    end;
                }
                action(Action168)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        //CurrPage.ProdOrderLines.PAGE.ShowDimensions;
                    end;
                }
                separator(Separator64)
                {
                }
                action("Ro&uting")
                {
                    ApplicationArea = All;
                    Caption = 'Ro&uting';
                    Image = Route;

                    trigger OnAction()
                    begin
                        //CurrPage.ProdOrderLines.PAGE.ShowRouting;
                    end;
                }
                action(Components)
                {
                    ApplicationArea = All;
                    Caption = 'Components';
                    Image = Components;

                    trigger OnAction()
                    begin
                        //CurrPage.ProdOrderLines.PAGE.ShowComponents;
                    end;
                }
                action(ItemTrackingLines)
                {
                    ApplicationArea = All;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        //CurrPage.ProdOrderLines.PAGE.OpenItemTrackingLines;
                    end;
                }
            }
        }
    }

    var
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
}

