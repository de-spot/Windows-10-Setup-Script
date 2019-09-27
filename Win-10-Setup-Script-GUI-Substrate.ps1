﻿Add-Type -AssemblyName "PresentationCore", "PresentationFramework", "WindowsBase"

[xml]$xamlMarkup = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"                        
        x:Name="Window"
        Title="Windows 10 Setup Script" MinHeight="905" MinWidth="760" Height="905" Width="760" FontFamily="Sergio UI"
        FontSize="16" TextOptions.TextFormattingMode="Display" WindowStartupLocation="CenterScreen" 
        SnapsToDevicePixels="True" WindowStyle="None" ResizeMode="CanResizeWithGrip" AllowsTransparency="True" 
        ShowInTaskbar="True" Background="#FAFAFA"
        Foreground="{DynamicResource {x:Static SystemColors.WindowTextBrushKey}}">

    <Window.Resources>

        <!--#region Brushes -->

        <SolidColorBrush x:Key="RadioButton.Static.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.Static.Border" Color="#FF333333"/>
        <SolidColorBrush x:Key="RadioButton.Static.Glyph" Color="#FF333333"/>

        <SolidColorBrush x:Key="RadioButton.MouseOver.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.Border" Color="#FF000000"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.Glyph" Color="#FF000000"/>

        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Background" Color="#FF4C91C8"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Border" Color="#FF4C91C8"/>
        <SolidColorBrush x:Key="RadioButton.MouseOver.On.Glyph" Color="#FFFFFFFF"/>

        <SolidColorBrush x:Key="RadioButton.Disabled.Background" Color="#FFFFFFFF"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.Border" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.Glyph" Color="#FF999999"/>

        <SolidColorBrush x:Key="RadioButton.Disabled.On.Background" Color="#FFCCCCCC"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.On.Border" Color="#FFCCCCCC"/>
        <SolidColorBrush x:Key="RadioButton.Disabled.On.Glyph" Color="#FFA3A3A3"/>

        <SolidColorBrush x:Key="RadioButton.Pressed.Background" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Pressed.Border" Color="#FF999999"/>
        <SolidColorBrush x:Key="RadioButton.Pressed.Glyph" Color="#FFFFFFFF"/>

        <SolidColorBrush x:Key="RadioButton.Checked.Background" Color="#FF0063B1"/>
        <SolidColorBrush x:Key="RadioButton.Checked.Border" Color="#FF0063B1"/>
        <SolidColorBrush x:Key="RadioButton.Checked.Glyph" Color="#FFFFFFFF"/>

        <!--#endregion-->

        <Style x:Key="ToggleSwitchLeftStyle" TargetType="{x:Type ToggleButton}">
            <Setter Property="Background" Value="{StaticResource RadioButton.Static.Background}"/>
            <Setter Property="BorderBrush" Value="{StaticResource RadioButton.Static.Border}"/>
            <Setter Property="Foreground" Value="{DynamicResource {x:Static SystemColors.ControlTextBrushKey}}"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="SnapsToDevicePixels" Value="True"/>
            <Setter Property="FocusVisualStyle" Value="{x:Null}"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="{x:Type ToggleButton}">
                        <Grid x:Name="templateRoot" 
							  Background="Transparent" 
							  SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}">
                            <VisualStateManager.VisualStateGroups>
                                <VisualStateGroup x:Name="CommonStates">
                                    <VisualState x:Name="Normal"/>
                                    <VisualState x:Name="MouseOver">
                                        <Storyboard>
                                            <DoubleAnimation To="0" Duration="0:0:0.2" Storyboard.TargetName="normalBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <DoubleAnimation To="1" Duration="0:0:0.2" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0:0:0.2">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="Fill" Duration="0:0:0.2">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Pressed">
                                        <Storyboard>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="pressedBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Pressed.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Disabled">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="CheckStates">
                                    <VisualState x:Name="Unchecked"/>
                                    <VisualState x:Name="Checked">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Static.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimationUsingKeyFrames Duration="0:0:0.5" Storyboard.TargetProperty="(UIElement.RenderTransform).(TransformGroup.Children)[3].(TranslateTransform.X)" Storyboard.TargetName="optionMark">
                                                <EasingDoubleKeyFrame KeyTime="0" Value="12"/>
                                            </DoubleAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Checked.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Indeterminate"/>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="FocusStates">
                                    <VisualState x:Name="Unfocused"/>
                                    <VisualState x:Name="Focused"/>
                                </VisualStateGroup>
                            </VisualStateManager.VisualStateGroups>
                            <Grid.RowDefinitions>
                                <RowDefinition />
                                <RowDefinition Height="Auto"/>
                            </Grid.RowDefinitions>
                            <ContentPresenter x:Name="contentPresenter" 
											  Focusable="False" RecognizesAccessKey="True" 
											  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" 
											  Margin="{TemplateBinding Padding}" 
											  SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}" 
											  VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
                            <Grid x:Name="markGrid" Grid.Row="1" Margin="10 0 10 0" Width="44" Height="20"
								  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}">
                                <Border x:Name="normalBorder" Opacity="1" BorderThickness="2" CornerRadius="10"
										BorderBrush="{TemplateBinding BorderBrush}" Background="{StaticResource RadioButton.Static.Background}"/>
                                <Border x:Name="checkedBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource  RadioButton.Checked.Border}" Background="{StaticResource RadioButton.Checked.Background}"/>
                                <Border x:Name="hoverBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.MouseOver.Border}" Background="{StaticResource RadioButton.MouseOver.Background}"/>
                                <Border x:Name="pressedBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.Pressed.Border}" Background="{StaticResource RadioButton.Pressed.Background}"/>
                                <Border x:Name="disabledBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.Disabled.Border}" Background="{StaticResource RadioButton.Disabled.Background}"/>
                                <Ellipse x:Name="optionMark"
										 Height="10" Width="10" Fill="{StaticResource RadioButton.Static.Glyph}" StrokeThickness="0" 
										 VerticalAlignment="Center" Margin="5,0" RenderTransformOrigin="0.5,0.5">
                                    <Ellipse.RenderTransform>
                                        <TransformGroup>
                                            <ScaleTransform/>
                                            <SkewTransform/>
                                            <RotateTransform/>
                                            <TranslateTransform X="-12"/>
                                        </TransformGroup>
                                    </Ellipse.RenderTransform>
                                </Ellipse>
                                <Ellipse x:Name="optionMarkOn" Opacity="0"
										 Height="10" Width="10" Fill="{StaticResource RadioButton.Checked.Glyph}" StrokeThickness="0" 
										 VerticalAlignment="Center" Margin="5,0" RenderTransformOrigin="0.5,0.5">
                                    <Ellipse.RenderTransform>
                                        <TransformGroup>
                                            <ScaleTransform/>
                                            <SkewTransform/>
                                            <RotateTransform/>
                                            <TranslateTransform X="12"/>
                                        </TransformGroup>
                                    </Ellipse.RenderTransform>
                                </Ellipse>
                            </Grid>
                        </Grid>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style x:Key="ToggleSwitchTopStyle" TargetType="{x:Type ToggleButton}">
            <Setter Property="Background" Value="{StaticResource RadioButton.Static.Background}"/>
            <Setter Property="BorderBrush" Value="{StaticResource RadioButton.Static.Border}"/>
            <Setter Property="Foreground" Value="{DynamicResource {x:Static SystemColors.ControlTextBrushKey}}"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="SnapsToDevicePixels" Value="True"/>
            <Setter Property="FocusVisualStyle" Value="{x:Null}"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="{x:Type ToggleButton}">
                        <Grid x:Name="templateRoot" 
							  Background="Transparent" 
							  SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}">
                            <VisualStateManager.VisualStateGroups>
                                <VisualStateGroup x:Name="CommonStates">
                                    <VisualState x:Name="Normal"/>
                                    <VisualState x:Name="MouseOver">
                                        <Storyboard>
                                            <DoubleAnimation To="0" Duration="0:0:0.2" Storyboard.TargetName="normalBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <DoubleAnimation To="1" Duration="0:0:0.2" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0:0:0.2">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="Fill" Duration="0:0:0.2">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Pressed">
                                        <Storyboard>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="pressedBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Pressed.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Disabled">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="CheckStates">
                                    <VisualState x:Name="Unchecked"/>
                                    <VisualState x:Name="Checked">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill" Duration="0">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Static.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimationUsingKeyFrames Duration="0:0:0.5" Storyboard.TargetProperty="(UIElement.RenderTransform).(TransformGroup.Children)[3].(TranslateTransform.X)" Storyboard.TargetName="optionMark">
                                                <EasingDoubleKeyFrame KeyTime="0" Value="12"/>
                                            </DoubleAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="optionMark" Storyboard.TargetProperty="Fill">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Checked.Glyph}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="hoverBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.MouseOver.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="optionMarkOn" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <DoubleAnimation To="1" Duration="0" Storyboard.TargetName="checkedBorder" Storyboard.TargetProperty="(UIElement.Opacity)"/>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="BorderBrush">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Border}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Duration="0" Storyboard.TargetName="disabledBorder" Storyboard.TargetProperty="Background">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource RadioButton.Disabled.On.Background}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Indeterminate"/>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="FocusStates">
                                    <VisualState x:Name="Unfocused"/>
                                    <VisualState x:Name="Focused"/>
                                </VisualStateGroup>
                            </VisualStateManager.VisualStateGroups>
                            <Grid.RowDefinitions>
                                <RowDefinition />
                                <RowDefinition Height="Auto"/>
                            </Grid.RowDefinitions>
                            <ContentPresenter x:Name="contentPresenter" 
											  Focusable="False" RecognizesAccessKey="True" 
											  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" 
											  Margin="{TemplateBinding Padding}" 
											  SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}" 
											  VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
                            <Grid x:Name="markGrid" Grid.Row="1" Margin="0 8 0 2" Width="44" Height="20"
								  HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}">
                                <Border x:Name="normalBorder" Opacity="1" BorderThickness="2" CornerRadius="10"
										BorderBrush="{TemplateBinding BorderBrush}" Background="Transparent"/>
                                <Border x:Name="checkedBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource  RadioButton.Checked.Border}" Background="{StaticResource RadioButton.Checked.Background}"/>
                                <Border x:Name="hoverBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.MouseOver.Border}" Background="Transparent"/>
                                <Border x:Name="pressedBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.Pressed.Border}" Background="{StaticResource RadioButton.Pressed.Background}"/>
                                <Border x:Name="disabledBorder" Opacity="0" BorderThickness="2" CornerRadius="10"
										BorderBrush="{StaticResource RadioButton.Disabled.Border}" Background="{StaticResource RadioButton.Disabled.Background}"/>
                                <Ellipse x:Name="optionMark"
										 Height="10" Width="10" Fill="{StaticResource RadioButton.Static.Glyph}" StrokeThickness="0" 
										 VerticalAlignment="Center" Margin="5,0" RenderTransformOrigin="0.5,0.5">
                                    <Ellipse.RenderTransform>
                                        <TransformGroup>
                                            <ScaleTransform/>
                                            <SkewTransform/>
                                            <RotateTransform/>
                                            <TranslateTransform X="-12"/>
                                        </TransformGroup>
                                    </Ellipse.RenderTransform>
                                </Ellipse>
                                <Ellipse x:Name="optionMarkOn" Opacity="0"
										 Height="10" Width="10" Fill="{StaticResource RadioButton.Checked.Glyph}" StrokeThickness="0" 
										 VerticalAlignment="Center" Margin="5,0" RenderTransformOrigin="0.5,0.5">
                                    <Ellipse.RenderTransform>
                                        <TransformGroup>
                                            <ScaleTransform/>
                                            <SkewTransform/>
                                            <RotateTransform/>
                                            <TranslateTransform X="12"/>
                                        </TransformGroup>
                                    </Ellipse.RenderTransform>
                                </Ellipse>
                            </Grid>
                        </Grid>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <SolidColorBrush x:Key="Hover.Enter.Brush" Color="#FFF2F2F2" />
        <SolidColorBrush x:Key="Hover.Exit.Brush" Color="#01FFFFFF" />

        <Storyboard x:Key="Hover.Enter.Storyboard"/>

        <Storyboard x:Key="Hover.Exit.Storyboard"/>

        <Style x:Key="HoverBorder" TargetType="Border">
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Margin" Value="0 4"/>
            <Setter Property="Padding" Value="10 2"/>
            <Style.Triggers>
                <EventTrigger RoutedEvent="Mouse.MouseEnter">
                    <BeginStoryboard Storyboard="{StaticResource Hover.Enter.Storyboard}" />
                </EventTrigger>
                <EventTrigger RoutedEvent="Mouse.MouseLeave">
                    <BeginStoryboard Storyboard="{StaticResource Hover.Exit.Storyboard}" />
                </EventTrigger>
            </Style.Triggers>
        </Style>

        <Style x:Key="TitleButtonStyle" TargetType="Canvas">
            <Setter Property="Height" Value="35"/>
            <Setter Property="Width" Value="35"/>
            <Style.Triggers>
                <Trigger Property="Canvas.IsMouseOver" Value="True">
                    <Setter Property="Canvas.Background" Value="#FF1744"/>
                </Trigger>
            </Style.Triggers>
        </Style>

        <Style x:Key="ButtonTextBlock" TargetType="{x:Type TextBlock}">
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="HorizontalAlignment" Value="Center"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Margin" Value="0 5 0 0"/>
        </Style>

        <Style x:Key="BorderHoverStyle" TargetType="{x:Type Border}">
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="{Binding ElementName=Window, Path=Background}"/>
                </Trigger>
                <Trigger Property="IsMouseOver" Value="False">
                    <Setter Property="Background" Value="{Binding ElementName=BorderPrivacy, Path=Background}"/>
                </Trigger>
            </Style.Triggers>
        </Style>

    </Window.Resources>

    <Border Name="BorderWindow" BorderThickness="1" BorderBrush="#0078d7">
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="40"/>
                <RowDefinition Height="45"/>
                <RowDefinition Height="*"/>                
            </Grid.RowDefinitions>
            <!--#region Title Panel-->
            <Grid Grid.Row="0" Margin="0 0 0 5" Background="{Binding ElementName=BorderWindow, Path=BorderBrush}">
                <Grid.Effect>
                    <DropShadowEffect ShadowDepth="2" Direction="315" BlurRadius="3" Opacity="0.5"/>
                </Grid.Effect>
                <!--Icon-->
                <Viewbox Width="28" Height="28" HorizontalAlignment="Left" Margin="10 0 0 3">
                    <Canvas Width="24" Height="24">
                        <Path Data="M3,12V6.75L9,5.43V11.91L3,12M20,3V11.75L10,11.9V5.21L20,3M3,13L9,13.09V19.9L3,18.75V13M20,13.25V22L10,20.09V13.1L20,13.25Z" Fill="{Binding ElementName=TitleHeader,Path=Foreground}" />
                    </Canvas>
                </Viewbox>
                <!--Header-->
                <TextBlock Name="TitleHeader" Text="Windows 10 Setup Script" FontFamily="Sergio UI" FontSize="14"
                           FontWeight="Bold" VerticalAlignment="Center" HorizontalAlignment="Center" Foreground="#FFFFFF"/>
                <!--Minimize Button-->
                <Canvas Name="MinimizeButton" VerticalAlignment="Center" HorizontalAlignment="Right" 
                        Margin="0 0 35 0" Style="{StaticResource TitleButtonStyle}">
                    <Viewbox Width="24" Height="24" Canvas.Left="4">
                        <Path  Data="M20,14H4V10H20" Fill="{Binding ElementName=TitleHeader,Path=Foreground}" />
                    </Viewbox>
                </Canvas>
                <!--Close Button-->
                <Canvas Name="CloseButton" VerticalAlignment="Center" HorizontalAlignment="Right" Style="{StaticResource TitleButtonStyle}">
                    <Viewbox Width="24" Height="24" Canvas.Left="4" Canvas.Top="2">
                        <Path Data="M19,6.41L17.59,5L12,10.59L6.41,5L5,6.41L10.59,12L5,17.59L6.41,19L12,13.41L17.59,19L19,17.59L13.41,12L19,6.41Z" Fill="{Binding ElementName=TitleHeader,Path=Foreground}" />
                    </Viewbox>
                </Canvas>
            </Grid>
            <!--#endregion Title Panel-->

            <!--#region Action Buttons Panel-->
            <StackPanel Name="ActionButtonsPanel" Height="40" Margin="0 0 0 5" Orientation="Horizontal" Grid.Row="1" VerticalAlignment="Center" HorizontalAlignment="Center">

                <!--#region Apply Setting Button-->
                <StackPanel Margin="10 0 0 0" Height="35" Width="35" Orientation="Horizontal">
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Style.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#DADADA"/>
                                </Trigger>
                                <Trigger Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="{Binding ElementName=Window, Path=Background}"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="130" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="35" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:0.5" To="10 4 0 0" SpeedRatio="5" AutoReverse="True" />
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Width="18" Height="18" VerticalAlignment="Center" HorizontalAlignment="Left" Margin="8 0 9 0">
                        <Canvas Width="24" Height="24">
                            <Path Data="M11,15H13V17H11V15M11,7H13V13H11V7M12,2C6.47,2 2,6.5 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M12,20A8,8 0 0,1 4,12A8,8 0 0,1 12,4A8,8 0 0,1 20,12A8,8 0 0,1 12,20Z"
                                  Fill="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="ApplyButtonText" Text="apply settings" FontSize="14" VerticalAlignment="Center"
                               Margin="0 0 8 0" Foreground="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                </StackPanel>
                <!--#endregion Apply Button-->

                <!--#region Save Setting Button-->
                <StackPanel Margin="10 0 0 0" Height="35" Width="35" Orientation="Horizontal">
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Style.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#DADADA"/>
                                </Trigger>
                                <Trigger Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="{Binding ElementName=Window, Path=Background}"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="125" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="35" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" To="10 4 0 0" SpeedRatio="5" AutoReverse="True"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Width="18" Height="18" VerticalAlignment="Center" HorizontalAlignment="Left" Margin="8 0 9 0">
                        <Canvas Width="24" Height="24">
                            <Path Data="M12,2A3,3 0 0,0 9,5C9,6.27 9.8,7.4 11,7.83V10H8V12H11V18.92C9.16,18.63 7.53,17.57 6.53,16H8V14H3V19H5V17.3C6.58,19.61 9.2,21 12,21C14.8,21 17.42,19.61 19,17.31V19H21V14H16V16H17.46C16.46,17.56 14.83,18.63 13,18.92V12H16V10H13V7.82C14.2,7.4 15,6.27 15,5A3,3 0 0,0 12,2M12,4A1,1 0 0,1 13,5A1,1 0 0,1 12,6A1,1 0 0,1 11,5A1,1 0 0,1 12,4Z"
                                  Fill="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="SaveButtonText" Text="save settings" FontSize="14" VerticalAlignment="Center"
                               Margin="0 0 8 0" Foreground="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                </StackPanel>
                <!--#endregion Save Setting Button-->

                <!--#region Load Setting Button-->
                <StackPanel Margin="10 0 0 0" Height="35" Width="35" Orientation="Horizontal">
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Style.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#DADADA"/>
                                </Trigger>
                                <Trigger Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="{Binding ElementName=Window, Path=Background}"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="125" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="35" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" To="10 4 0 0" SpeedRatio="5" AutoReverse="True"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Width="18" Height="18" VerticalAlignment="Center" HorizontalAlignment="Left" Margin="8 0 9 0">
                        <Canvas Width="24" Height="24">
                            <Path Data="M7.5,5.6L5,7L6.4,4.5L5,2L7.5,3.4L10,2L8.6,4.5L10,7L7.5,5.6M19.5,15.4L22,14L20.6,16.5L22,19L19.5,17.6L17,19L18.4,16.5L17,14L19.5,15.4M22,2L20.6,4.5L22,7L19.5,5.6L17,7L18.4,4.5L17,2L19.5,3.4L22,2M13.34,12.78L15.78,10.34L13.66,8.22L11.22,10.66L13.34,12.78M14.37,7.29L16.71,9.63C17.1,10 17.1,10.65 16.71,11.04L5.04,22.71C4.65,23.1 4,23.1 3.63,22.71L1.29,20.37C0.9,20 0.9,19.35 1.29,18.96L12.96,7.29C13.35,6.9 14,6.9 14.37,7.29Z" 
                                  Fill="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="LoadButtonText" Text="load settings" FontSize="14" VerticalAlignment="Center"
                               Margin="0 0 8 0" Foreground="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                </StackPanel>
                <!--#endregion Load Setting Button-->

                <!--#region Change Language Button-->
                <StackPanel Margin="10 0 0 0" Height="35" Width="35" Orientation="Horizontal">
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Style.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#DADADA"/>
                                </Trigger>
                                <Trigger Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="{Binding ElementName=Window, Path=Background}"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="150" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="35" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" To="10 4 0 0" SpeedRatio="5" AutoReverse="True"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Width="18" Height="18" VerticalAlignment="Center" HorizontalAlignment="Left" Margin="8 0 9 0">
                        <Canvas Width="24" Height="24">
                            <Path Data="M16.36,14C16.44,13.34 16.5,12.68 16.5,12C16.5,11.32 16.44,10.66 16.36,10H19.74C19.9,10.64 20,11.31 20,12C20,12.69 19.9,13.36 19.74,14M14.59,19.56C15.19,18.45 15.65,17.25 15.97,16H18.92C17.96,17.65 16.43,18.93 14.59,19.56M14.34,14H9.66C9.56,13.34 9.5,12.68 9.5,12C9.5,11.32 9.56,10.65 9.66,10H14.34C14.43,10.65 14.5,11.32 14.5,12C14.5,12.68 14.43,13.34 14.34,14M12,19.96C11.17,18.76 10.5,17.43 10.09,16H13.91C13.5,17.43 12.83,18.76 12,19.96M8,8H5.08C6.03,6.34 7.57,5.06 9.4,4.44C8.8,5.55 8.35,6.75 8,8M5.08,16H8C8.35,17.25 8.8,18.45 9.4,19.56C7.57,18.93 6.03,17.65 5.08,16M4.26,14C4.1,13.36 4,12.69 4,12C4,11.31 4.1,10.64 4.26,10H7.64C7.56,10.66 7.5,11.32 7.5,12C7.5,12.68 7.56,13.34 7.64,14M12,4.03C12.83,5.23 13.5,6.57 13.91,8H10.09C10.5,6.57 11.17,5.23 12,4.03M18.92,8H15.97C15.65,6.75 15.19,5.55 14.59,4.44C16.43,5.07 17.96,6.34 18.92,8M12,2C6.47,2 2,6.5 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2Z"
                                  Fill="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="ChangeLanguageButtonText" Text="change language" FontSize="14" VerticalAlignment="Center"
                               Margin="0 0 8 0" Foreground="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                </StackPanel>
                <!--#endregion Change Language Button-->

                <!--#region Github Button-->
                <StackPanel Margin="10 0 0 0" Height="35" Width="35" Orientation="Horizontal">
                    <StackPanel.Style>
                        <Style TargetType="{x:Type StackPanel}">
                            <Style.Triggers>
                                <Trigger Property="IsMouseOver" Value="True">
                                    <Setter Property="Background" Value="#DADADA"/>
                                </Trigger>
                                <Trigger Property="IsMouseOver" Value="False">
                                    <Setter Property="Background" Value="{Binding ElementName=Window, Path=Background}"/>
                                </Trigger>
                                <EventTrigger RoutedEvent="MouseEnter">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="135" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseLeave">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <DoubleAnimation Storyboard.TargetProperty="Width" Duration="0:0:1" To="35" SpeedRatio="3"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                                <EventTrigger RoutedEvent="MouseDown">
                                    <EventTrigger.Actions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ThicknessAnimation Storyboard.TargetProperty="Margin" Duration="0:0:1" To="10 4 0 0" SpeedRatio="5" AutoReverse="True"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </EventTrigger.Actions>
                                </EventTrigger>
                            </Style.Triggers>
                        </Style>
                    </StackPanel.Style>
                    <Viewbox Width="18" Height="18" VerticalAlignment="Center" HorizontalAlignment="Left" Margin="8 0 9 0">
                        <Canvas Width="24" Height="24">
                            <Path Data="M12,2A10,10 0 0,0 2,12C2,16.42 4.87,20.17 8.84,21.5C9.34,21.58 9.5,21.27 9.5,21C9.5,20.77 9.5,20.14 9.5,19.31C6.73,19.91 6.14,17.97 6.14,17.97C5.68,16.81 5.03,16.5 5.03,16.5C4.12,15.88 5.1,15.9 5.1,15.9C6.1,15.97 6.63,16.93 6.63,16.93C7.5,18.45 8.97,18 9.54,17.76C9.63,17.11 9.89,16.67 10.17,16.42C7.95,16.17 5.62,15.31 5.62,11.5C5.62,10.39 6,9.5 6.65,8.79C6.55,8.54 6.2,7.5 6.75,6.15C6.75,6.15 7.59,5.88 9.5,7.17C10.29,6.95 11.15,6.84 12,6.84C12.85,6.84 13.71,6.95 14.5,7.17C16.41,5.88 17.25,6.15 17.25,6.15C17.8,7.5 17.45,8.54 17.35,8.79C18,9.5 18.38,10.39 18.38,11.5C18.38,15.32 16.04,16.16 13.81,16.41C14.17,16.72 14.5,17.33 14.5,18.26C14.5,19.6 14.5,20.68 14.5,21C14.5,21.27 14.66,21.59 15.17,21.5C19.14,20.16 22,16.42 22,12A10,10 0 0,0 12,2Z"
                                  Fill="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                        </Canvas>
                    </Viewbox>
                    <TextBlock Name="GithubButtonText" Text="follow on githib" FontSize="14" VerticalAlignment="Center"
                               Margin="0 0 8 0" Foreground="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                </StackPanel>
                <!--#endregion Change Language Button-->
            </StackPanel>
            <!--#endregion Action Buttons Panel-->

            <!--#region Alert Panel-->
            <StackPanel Name="AlertPanel" Height="40" Visibility="Collapsed" Orientation="Horizontal" Grid.Row="2" VerticalAlignment="Center">

            </StackPanel>
            <!--#endregion Alert Panel-->

            <!--#region Toggle Buttons Panel-->
            <ScrollViewer Grid.Row="3" VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Disabled">
                <StackPanel Orientation="Vertical">

                    <!--#region Privacy & Telemetry-->
                    <StackPanel Orientation="Vertical" VerticalAlignment="Top">
                        <Border Name="BorderPrivacy" BorderBrush="#DADADA" BorderThickness="1 0 1 1" Margin="10 0 10 0" Height="43" Background="#FFFFFF">
                            <TextBlock Text="Privacy &amp; Telemetry Settings" FontSize="16" VerticalAlignment="Center" HorizontalAlignment="Left" Margin="28 0 10 0"/>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy0" Text="Change Windows Feedback frequency to &quot;Never&quot;" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy0, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy0, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy1" Text="Turn off automatic installing suggested apps" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy1, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy1, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy2" Text="Turn off &quot;Connected User Experiences and Telemetry&quot; service" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy2, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy2, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy3" Text="Turn off the SQMLogger session at the next computer restart" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy3, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy3, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy4" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy4" Text="Do not allow apps to use advertising ID" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy4, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy4, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy5" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy5" Text="Do not use sign-in info to automatically finish setting up device after an update or restart" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy5, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy5, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy6" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy6" Text="Do not let websites provide locally relevant content by accessing language list" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy6, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy6, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy7" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy7" Text="Turn off suggested content in the Settings" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy7, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy7, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy8" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy8" Text="Turn off tip, trick, and suggestions as you use Windows" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy8, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy8, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy9" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy9" Text="Turn off reserved storage" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy9, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy9, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy10" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy10" Text="Do not let apps on other devices open and message apps on this device, and vice versa" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy10, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy10, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy11" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy11" Text="Set the operating system diagnostic data level to &quot;Basic&quot;" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy11, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy11, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy12" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy12" Text="Turn off the Autologger session at the next computer restart" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy12, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy12, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy13" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy13" Text="Turn off per-user services" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy13, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy13, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy14" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy14" Text="Do not offer tailored experiences based on the diagnostic data setting" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy14, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy14, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy15" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy15" Text="Turn off diagnostics tracking scheduled tasks" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy15, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy15, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchPrivacy16" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBoxPrivacy16" Text="Turn off Windows Error Reporting" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy16, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchPrivacy16, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <!--Placeholder Panel-->
                        <StackPanel Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Height="{Binding ElementName=BorderPrivacy, Path=Height}" Background="Transparent"/>
                    </StackPanel>
                    <!--#endregion Privacy & Telemetry-->

                    <!--#region UI & Personalization-->
                    <StackPanel Orientation="Vertical" VerticalAlignment="Top">
                        <Border Name="BorderUi" BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}"  Background="{Binding ElementName=BorderPrivacy, Path=Background}" Height="{Binding ElementName=BorderPrivacy, Path=Height}">
                            <TextBlock Text="User Interface &amp; Personalization Settings" FontSize="16" VerticalAlignment="Center" HorizontalAlignment="Left" Margin="28 0 10 0"/>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi0" Text="Set the Control Panel view by large icons" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi0, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi0, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi1" Text="Hide search box or search icon on taskbar" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi1, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi1, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi2" Text="Turn off &quot;New App Installed&quot; notification" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi2, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi2, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi3" Text="Turn off automatically hiding scroll bars" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi3, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi3, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi4" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi4" Text="Hide all folders in the navigation pane" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi4, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi4, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi5" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi5" Text="Hide &quot;Frequent folders&quot; in Quick access" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi5, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi5, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi6" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi6" Text="Choose theme color for default app mode" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi6, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi6, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi7" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi7" Text="Show File Name Extensions" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi7, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi7, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi8" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi8" Text="Show &quot;This PC&quot; on Desktop" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi8, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi8, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi9" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi9" Text="Show Task Manager details" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi9, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi9, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi10" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi10" Text="Remove Microsoft Edge shortcut from the Desktop" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi10, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi10, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi11" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi11" Text="Import Start menu layout from pre-saved reg file" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi11, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi11, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi12" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi12" Text="Show more details in file transfer dialog" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi12, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi12, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi13" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi13" Text="Turn off recently added apps on Start Menu" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi13, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi13, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi14" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi14" Text="Remove the &quot;Previous Versions&quot; tab from properties context menu" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi14, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi14, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi15" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi15" Text="Show more Windows Update restart notifications about restarting" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi15, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi15, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi16" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi16" Text="Turn off check boxes to select items" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi16, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi16, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi17" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi17" Text="Turn on acrylic taskbar transparency" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi17, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi17, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi18" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi18" Text="Always show all icons in the notification area" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi18, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi18, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi19" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi19" Text="Hide &quot;Windows Ink Workspace&quot; button in taskbar" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi19, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi19, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi20" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi20" Text="Hide Task View button on taskbar" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi20, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi20, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi21" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi21" Text="Turn off thumbnail cache removal" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi21, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi21, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi22" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi22" Text="Show accent color on the title bars and window borders" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi22, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi22, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi23" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi23" Text="Save screenshots by pressing Win+PrtScr to the Desktop" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi23, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi23, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi24" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi24" Text="Turn on ribbon in File Explorer" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi24, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi24, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi25" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi25" Text="Turn on recycle bin files delete confirmation" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi25, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi25, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi26" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi26" Text="Choose theme color for default Windows mode" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi26, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi26, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi27" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi27" Text="Turn off user first sign-in animation" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi27, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi27, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi28" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi28" Text="Let Windows try to fix apps so they're not blurry" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi28, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi28, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi29" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi29" Text="Turn off the &quot;- Shortcut&quot; name extension for new shortcuts" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi29, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi29, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi30" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi30" Text="Turn off JPEG desktop wallpaper import quality reduction" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi30, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi30, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi31" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi31" Text="Unpin Microsoft Edge and Microsoft Store from taskbar" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi31, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi31, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi32" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi32" Text="Show seconds on taskbar clock" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi32, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi32, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi33" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi33" Text="Hide People button on the taskbar" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi33, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi33, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi34" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi34" Text="Turn off Snap Assist" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi34, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi34, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi35" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi35" Text="Show Hidden Files, Folders, and Drives" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi35, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi35, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi36" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi36" Text="Show folder merge conflicts" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi36, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi36, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi37" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi37" Text="Hide &quot;Recent files&quot; in Quick access" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi37, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi37, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi38" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi38" Text="Turn off creation of an Edge shortcut on the desktop for each user profile" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi38, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi38, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi39" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi39" Text="Remove 3D Objects folder in &quot;This PC&quot; and in the navigation pane" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi39, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi39, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi40" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi40" Text="Turn off app launch tracking to improve Start menu and search results" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi40, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi40, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchUi41" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockUi41" Text="Set File Explorer to open to This PC by default" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi41, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchUi41, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <!--Placeholder Panel-->
                        <StackPanel Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Height="{Binding ElementName=BorderPrivacy, Path=Height}" Background="Transparent"/>
                    </StackPanel>
                    <!--#endregion UI & Personalization-->

                    <!--#region System-->
                    <StackPanel Orientation="Vertical" VerticalAlignment="Top">
                        <Border Name="BorderSystem" BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}"  Background="{Binding ElementName=BorderPrivacy, Path=Background}" Height="{Binding ElementName=BorderPrivacy, Path=Height}">
                            <TextBlock Text="System Settings" FontSize="16" VerticalAlignment="Center" HorizontalAlignment="Left" Margin="28 0 10 0"/>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem0" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem0" Text="Group svchost.exe processes" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem0, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem0, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem1" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem1" Text="Remove Windows capabilities" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem1, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem1, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem2" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem2" Text="Turn on Num Lock at startup" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem2, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem2, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem3" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem3" Text="Turn on the display of stop error information on the BSoD" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem3, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem3, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem4" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem4" Text="Always wait for the network at computer startup and logon" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem4, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem4, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem5" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem5" Text="Turn on Storage Sense to automatically free up space" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem5, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem5, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem6" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem6" Text="Set the default input method to the English language" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem6, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem6, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem7" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem7" Text="Do not allow the computer to turn off the device to save power for desktop" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem7, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem7, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem8" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem8" Text="Turn off &quot;The Windows Filtering Platform has blocked a connection&quot; message" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem8, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem8, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem9" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem9" Text="Turn off default background apps except" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem9, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem9, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem10" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem10" Text="Turn off SmartScreen for apps and files" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem10, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem10, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem11" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem11" Text="Turn on .NET 4 runtime for all apps" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem11, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem11, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem12" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem12" Text="Launch folder in a separate process" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem12, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem12, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem13" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem13" Text="Turn off hibernate" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem13, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem13, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem14" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem14" Text="Uninstall Onedrive" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem14, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem14, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem15" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem15" Text="Delete temporary files that apps aren't using" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem15, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem15, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem16" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem16" Text="Turn on automatic recommended troubleshooting" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem16, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem16, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem17" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem17" Text="Delete files in recycle bin if they have been there for over 30 days" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem17, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem17, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem18" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem18" Text="Open shortcut to the Command Prompt from Start menu as Administrator" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem18, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem18, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem19" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem19" Text="Turn off app suggestions on Start menu" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem19, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem19, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem20" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem20" Text="Turn on firewall &amp; network protection" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem20, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem20, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem21" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem21" Text="Remove printers" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem21, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem21, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem22" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem22" Text="Turn on Windows Sandbox" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem22, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem22, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem23" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem23" Text="Turn off sticky Shift key after pressing 5 times" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem23, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem23, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem24" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem24" Text="Set power management scheme for desktop and laptop" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem24, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem24, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem25" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem25" Text="Turn off Windows Script Host" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem25, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem25, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem26" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem26" Text="Set &quot;High performance&quot; in graphics performance preference for apps" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem26, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem26, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem27" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem27" Text="Automatically adjust active hours for me based on daily usage" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem27, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem27, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem28" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem28" Text="Turn on automatic backup the system registry to the 'C:\Windows\System32\config\RegBack' folder" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem28, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem28, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem29" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem29" Text="Set location of the &quot;Desktop&quot;, &quot;Documents&quot; &quot;Downloads&quot; &quot;Music&quot;, &quot;Pictures&quot; and &quot;Videos&quot;" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem29, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem29, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem30" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem30" Text="Use the PrtScn button to open screen snipping" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem30, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem30, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem31" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem31" Text="Create old style shortcut for &quot;Devices and Printers&quot; in 'C:\Users\dmitriy.demin\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools'" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem31, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem31, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem32" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem32" Text="Turn off F1 Help key" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem32, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem32, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem33" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem33" Text="Turn on Win32 long paths" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem33, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem33, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem34" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem34" Text="Turn on Retpoline patch against Spectre v2" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem34, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem34, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem35" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem35" Text="Do not preserve zone information" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem35, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem35, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem36" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem36" Text="Change environment variable for 'C:\Temp' to 'C:\Temp'" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem36, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem36, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem37" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem37" Text="Run Storage Sense every month" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem37, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem37, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem38" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem38" Text="Never delete files in &quot;Downloads&quot; folder" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem38, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem38, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem39" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem39" Text="Turn off location for this device" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem39, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem39, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem40" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem40" Text="Turn off Admin Approval Mode for administrators" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem40, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem40, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem41" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem41" Text="Turn off Windows features" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem41, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem41, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem42" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem42" Text="Turn on updates for other Microsoft products" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem42, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem42, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem43" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem43" Text="Enable System Restore" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem43, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem43, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem44" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem44" Text="Do not allow Windows 10 to manage default printer" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem44, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem44, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem45" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem45" TextWrapping="Wrap" Text="Turn on access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem45, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem45, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem46" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem46" Text="Set download mode for delivery optization on &quot;HTTP only&quot;" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem46, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem46, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="{Binding ElementName=BorderPrivacy, Path=BorderBrush}" BorderThickness="{Binding ElementName=BorderPrivacy, Path=BorderThickness}" Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Style="{StaticResource BorderHoverStyle}">
                            <StackPanel Orientation="Horizontal" Margin="10">
                                <Grid HorizontalAlignment="Left">
                                    <ToggleButton Name="ToggleSwitchSystem47" Style="{DynamicResource ToggleSwitchLeftStyle}" IsChecked="False"/>
                                    <TextBlock Name="TexBlockSystem47" Text="Turn off Cortana" Margin="65 0 10 0" VerticalAlignment="Center" IsHitTestVisible="False">
                                        <TextBlock.Style>
                                            <Style TargetType="{x:Type TextBlock}">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem47, Path=IsChecked}" Value="True">
                                                        <Setter Property="Foreground" Value="{Binding ElementName=BorderWindow, Path=BorderBrush}"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding ElementName=ToggleSwitchSystem47, Path=IsEnabled}" Value="false">
                                                        <Setter Property="Opacity" Value="0.2" />
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </TextBlock.Style>
                                    </TextBlock>
                                </Grid>
                            </StackPanel>
                        </Border>
                        <!--Placeholder Panel-->
                        <StackPanel Margin="{Binding ElementName=BorderPrivacy, Path=Margin}" Height="{Binding ElementName=BorderPrivacy, Path=Height}" Background="Transparent"/>
                    </StackPanel>
                </StackPanel>
            </ScrollViewer>
            <!--#endregion Toggle Buttons Panel-->
        </Grid>
    </Border>
</Window>
'@

$xamlGui = [System.Windows.Markup.XamlReader]::Load((New-Object System.Xml.XmlNodeReader $xamlMarkup))
$xamlMarkup.SelectNodes('//*[@Name]') | ForEach-Object {
    
    if ($_.Name.Contains("ToggleButton")) {

        $ToggleBtn = $xamlGui.FindName($_.Name)
        [Void]$ToggleButtons.Add($ToggleBtn)
    }
	
	else
	{
		New-Variable -Name $_.Name -Value $xamlGui.FindName($_.Name)
	}    
}

#region Script Functions
function Hide-Console {
    <#
    .SYNOPSIS
    Hide Powershell console before show WPF GUI.    
    #>

    [CmdletBinding()]
    param ()

    Add-Type -Name Window -Namespace Console -MemberDefinition '
    [DllImport("Kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();

    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
    [Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0)
}

#endregion

#region Controls Events

$xamlGui.add_MouseLeftButtonDown( {
        $xamlGui.DragMove()
    })

$MinimizeButton.add_MouseLeftButtonDown( {
        $xamlGui.WindowState = "Minimized"
    })

$CloseButton.add_MouseLeftButtonDown( {
        $xamlGui.Close()
    })

#endregion

Hide-Console
$xamlGui.ShowDialog() | Out-Null